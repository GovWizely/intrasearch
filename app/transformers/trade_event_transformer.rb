require 'uri'

require 'industry'
require 'taxonomy_attributes_transformer'

module TradeEventTransformer
  extend TaxonomyAttributesTransformer

  URL_PREFIX = Intrasearch.config['trade_event_url_prefix'].freeze

  module ModuleMethods
    def transform(attributes)
      transform_countries_and_venues attributes
      transform_countries_and_regions attributes,
                                      attributes[:countries]
      transform_industries attributes
      transform_url attributes
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

    def transform_url(attributes)
      encoded_id = URI.encode_www_form_component attributes[:id]
      attributes[:url] = "#{URL_PREFIX}#{encoded_id}"
    end
  end

  extend ModuleMethods
end
