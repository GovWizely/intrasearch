require 'uri'

require 'country'
require 'industry'
require 'topic'
require 'transformer'

module BaseArticleTransformer
  def self.extended(base)
    base.extend Transformer
  end

  extend self

  URL_PREFIX = YAML.load(Intrasearch.root.join('config/intrasearch.yml').read)[Intrasearch.env]['article_url_prefix'].freeze

  def transform(attributes)
    transform_countries attributes
    transform_industries attributes
    transform_topics attributes
    transform_url_name attributes
    attributes
  end

  protected

  def transform_countries(attributes)
    valid_countries = Country.search_by_labels(*attributes[:geographies])
    attributes[:countries] = valid_countries.map(&:label).sort
    attributes[:trade_regions] = valid_countries.map(&:trade_regions).flatten.uniq.sort
    attributes[:world_region_paths] = valid_countries.map(&:world_region_paths).flatten.uniq.sort
    attributes[:world_regions] = valid_countries.map(&:world_regions).flatten.uniq.sort
    attributes
  end

  def transform_industries(attributes)
    transform_taxonomies Industry, attributes, attributes[:industries]
    attributes
  end

  def transform_topics(attributes)
    labels = attributes.delete(:trade_topics) || []
    transform_taxonomies Topic, attributes, labels
  end

  def transform_taxonomies(klass, attributes, labels)
    taxonomies = klass.search_by_labels(*labels)
    paths = taxonomies.map(&:path).uniq.sort
    attributes["#{klass.name.downcase}_paths"] = paths
    attributes[klass.name.tableize] = paths_to_labels paths
    attributes
  end

  def transform_url_name(attributes)
    if attributes[:url_name].present?
      attributes[:url] = "#{URL_PREFIX}#{URI.encode_www_form_component(attributes[:url_name])}"
    end
    attributes
  end
end
