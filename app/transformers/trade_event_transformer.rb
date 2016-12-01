require 'time'
require 'uri'

require 'industry'
require 'namespaced_id_by_source_transformer'
require 'taxonomy_attributes_transformer'

module TradeEventTransformer
  URL_PREFIX = Intrasearch.config['trade_event_url_prefix'].freeze

  def self.extended(base)
    base.extend NamespacedIdBySourceTransformer
    base.extend TaxonomyAttributesTransformer
    base.extend ModuleMethods
  end

  module ModuleMethods
    def transform(attributes)
      transform_id attributes
      transform_cost attributes
      transform_countries_and_venues attributes
      transform_countries_and_regions attributes,
                                      attributes[:countries]
      attributes[:industries] ||= []
      attributes[:industries] &&= attributes[:industries].sort
      attributes[:expanded_industries] = attributes[:industries]
      transform_industries attributes, :expanded_industries
      transform_hosted_url attributes
      transform_time attributes, :start_time, :end_time
      attributes
    end

    private

    def transform_cost(attributes)
      attributes[:cost] &&= attributes[:cost].to_f rescue nil
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

    def transform_time(attributes, *keys)
      keys.each do |key|
        attributes[key] &&= normalize_time attributes[key]
      end
    end

    def normalize_time(time_str)
      Time.parse(time_str).strftime('%-I:%M %p') rescue time_str
    end
  end

  extend self
end
