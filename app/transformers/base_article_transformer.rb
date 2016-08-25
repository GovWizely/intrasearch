require 'uri'

require 'taxonomy_attributes_transformer'
require 'topic'

module BaseArticleTransformer
  def self.extended(base)
    base.extend TaxonomyAttributesTransformer
  end

  extend self

  URL_PREFIX = Intrasearch.config['article_url_prefix'].freeze

  def transform(attributes)
    countries = attributes.delete(:geographies) || []
    transform_countries_and_regions attributes, countries
    transform_industries attributes
    transform_topics attributes
    transform_url_name attributes
    transform_url attributes
    attributes
  end

  protected

  def transform_topics(attributes)
    attributes[:topics] = attributes.delete(:trade_topics) || []
    transform_taxonomies Topic, attributes, :topics
  end

  def transform_url_name(attributes)
    attributes[:url_name] &&= URI.encode_www_form_component attributes[:url_name]
  end

  def transform_url(attributes)
    attributes[:url] = "#{URL_PREFIX}#{attributes[:url_name]}"
  end
end
