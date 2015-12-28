require 'uri'

require 'country'
require 'industry'
require 'taxonomy_search'
require 'topic'

class ArticleTransformer
  URL_PREFIX = YAML.load(File.read(Nix.root.join('config/intrasearch.yml')))[Nix.env]['article_url_prefix'].freeze

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
    attributes[:trade_regions] = valid_countries.map(&:trade_regions).sort
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
    attributes["#{klass.name.downcase}_paths"] = taxonomies.map(&:path).uniq.sort
    attributes["#{klass.name.tableize}"] = taxonomies.map(&:label).uniq.sort
    attributes
  end

  def transform_url_name(attributes)
    if attributes[:url_name].present?
      attributes[:url] = "#{URL_PREFIX}#{URI.encode_www_form_component(attributes[:url_name])}"
    end
    attributes
  end
end
