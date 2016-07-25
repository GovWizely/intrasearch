require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'
require 'sanitize'

require 'webservices/trade_event'

require 'trade_event/attribute_mapping_builder'

module TradeEvent
  module TradeEventExtractor
    def self.extended(base)
      base.module_eval do
        @attribute_mapping = {}
        @source = base.name.demodulize.sub(/TradeEventExtractor$/, '').upcase
      end

      class << base
        attr_reader :attribute_mapping, :source
      end

      base.extend ModuleMethods
    end

    module ModuleMethods
      def extract
        trade_events = Webservices::TradeEvent.all sources: source
        Enumerator.new do |y|
          trade_events.each do |trade_event|
            y << extract_attributes(attribute_mapping, trade_event)
          end
        end
      end

      protected

      def attribute(name, options = {})
        @attribute_mapping.merge! AttributeMappingBuilder.build(name, options)
      end

      private

      def extract_attributes(mappings, source_hash)
        mappings.each_with_object({}) do |(name, options), result_hash|
          result_hash[name] = extract_attribute options, source_hash[options[:key]]
        end
      end

      def extract_attribute(mapping_options, value)
        if value.is_a? Array
          extract_array_value mapping_options, value
        else
          sanitize_value value
        end
      end

      def extract_array_value(mapping_options, array_value)
        if (mappings = mapping_options[:attributes])
          array_value.map do |source_hash|
            extract_attributes mappings, source_hash
          end
        else
          array_value
        end
      end

      def sanitize_value(value)
        Sanitize.fragment(value).squish if value.present?
      end
    end
  end
end
