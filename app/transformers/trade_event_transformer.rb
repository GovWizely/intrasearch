require 'uri'

require 'industry'
require 'taxonomy_attributes_transformer'

module TradeEventTransformer
  URL_PREFIX = Intrasearch.config['trade_event_url_prefix'].freeze

  def self.extended(base)
    base.extend TaxonomyAttributesTransformer
    base.extend ModuleMethods
  end

  module ModuleMethods
    def transform(attributes)
      transform_cost attributes
      transform_countries_and_venues attributes
      transform_countries_and_regions attributes,
                                      attributes[:countries]
      attributes[:industries] &&= attributes[:industries].sort
      attributes[:expanded_industries] = attributes[:industries]
      transform_industries attributes, :expanded_industries
      transform_hosted_url attributes
      attributes
    end

    private

    def transform_cost(attributes)
      attributes[:cost] &&= attributes[:cost].to_f rescue 0.0
    end

    def transform_countries_and_venues(attributes)
      if attributes[:venues].present?
        attributes[:countries] = attributes[:venues].map { |v| v[:country] }.uniq.compact
      else
        attributes[:countries] = []
        attributes[:venues] = []
      end
    end

    def transform_hosted_url(attributes)
      encoded_id = URI.encode_www_form_component attributes[:id]
      attributes[:hosted_url] = "#{URL_PREFIX}#{encoded_id}"
    end
  end

  extend self
end
