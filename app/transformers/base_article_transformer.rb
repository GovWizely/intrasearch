require 'taxonomy_attributes_transformer'
require 'topic'
require 'url_transformer'

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
    UrlTransformer.transform attributes,
                             URL_PREFIX,
                             attributes[:url_name]
    attributes
  end

  protected

  def transform_topics(attributes)
    labels = attributes.delete(:trade_topics) || []
    transform_taxonomies Topic, attributes, labels
  end
end
