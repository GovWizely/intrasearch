require 'active_support/core_ext/string/inflections'
require 'forwardable'

require 'base_model'
require 'trade_event/trade_event_extra'

module TradeEvent
  module BaseModel
    def self.included(base)
      base.include ::BaseModel
      base.extend ModuleMethods
      base.include InstanceMethods

      base.extend Forwardable
      base.def_delegators :extra, :md_description, :html_description

      base.class_eval do
        @index_version = 'v3'

        append_index_namespace parent.name.tableize,
                               name.demodulize.tableize

        define_attributes

        validates_presence_of :hosted_url, :name, :source
      end
    end

    module ModuleMethods
      protected

      def load_attributes_config
        yaml = Intrasearch.root.join('config/trade_event_attributes.yml').read
        source = name.demodulize.sub(/TradeEvent/, '').upcase
        YAML.load(yaml)[source]
      end

      def define_attributes
        config = load_attributes_config
        define_custom_attributes config[:custom_attributes]
        define_date_attributes config[:date_attributes]
        define_not_analyzed_attributes config[:not_analyzed_attributes]
      end

      def define_custom_attributes(attributes_config)
        return unless attributes_config.present?
        attributes_config.each do |config|
          attribute config[:name], config[:type], mapping: config[:mapping].dup
        end
      end

      def define_date_attributes(names)
        return unless names
        names.each do |name|
          attribute name,
                    Date,
                    mapping: {
                      format: 'strict_date',
                      index: 'not_analyzed'
                    }
        end
      end

      def define_not_analyzed_attributes(names)
        not_analyzed_attributes(*names) if names.present?
      end
    end

    module InstanceMethods
      def attributes
        ActiveSupport::HashWithIndifferentAccess.new super
      end

      def update_extra_attributes(extra_attributes)
        @extra = TradeEventExtra.create extra_attributes.merge id: id
        @extra.persisted?
      end

      def extra
        load_extra unless @extra
        @extra
      end

      def description
        extra.html_description.present? ? extra.html_description : original_description
      end

      private

      def load_extra
        @extra = begin
          TradeEventExtra.find id
        rescue Elasticsearch::Persistence::Repository::DocumentNotFound
          TradeEventExtra.new
        end
      end

    end
  end
end
