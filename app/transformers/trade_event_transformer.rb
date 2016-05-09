require 'industry'
require 'taxonomy_attributes_transformer'
require 'url_transformer'

module TradeEventTransformer
  extend TaxonomyAttributesTransformer

  URL_PREFIX = Intrasearch.config['trade_event_url_prefix'].freeze

  module ModuleMethods
    def transform(attributes)
      transform_countries_and_venues attributes
      transform_countries_and_regions attributes,
                                      attributes[:countries]
      transform_industries attributes
      UrlTransformer.transform attributes,
                               URL_PREFIX,
                               attributes[:id]
      attributes
    end

    private

    def transform_countries_and_venues(attributes)
      if attributes[:venues].present?
        attributes[:countries] = attributes[:venues].map { |v| v[:country] }.uniq.compact
        attributes[:venues] = attributes[:venues].map { |v| v[:venue] }.uniq.compact
      else
        attributes[:countries] = []
        attributes[:venues] = []
      end
    end
  end

  extend ModuleMethods
end
