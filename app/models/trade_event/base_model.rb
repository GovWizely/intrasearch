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
        @index_version = 'v2'

        append_index_namespace parent.name.tableize,
                               name.demodulize.tableize

        analyzed_attributes 'english_analyzer',
                            :original_description,
                            :name

        not_analyzed_attributes :source,
                                :hosted_url

        date_attributes :start_date

        validates_presence_of :hosted_url, :name, :source
      end
    end

    module ModuleMethods
      protected

      def date_attributes(*names)
        names.each do |name|
          attribute name,
                    Date,
                    mapping: {
                      format: 'strict_date',
                      index: 'not_analyzed'
                    }
        end
      end

      def contacts_attribute
        attribute :contacts,
                  nil,
                  mapping: {
                    type: 'nested',
                    properties: {
                      first_name: { type: 'string', index: 'not_analyzed' },
                      last_name: { type: 'string', index: 'not_analyzed' },
                      person_title: { type: 'string', index: 'not_analyzed' },
                      post: { type: 'string', index: 'not_analyzed' },
                      email: { type: 'string', index: 'not_analyzed' },
                      phone: { type: 'string', index: 'not_analyzed' }
                    }
                  }
      end

      def venues_attribute
        attribute :venues,
                  nil,
                  mapping: {
                    type: 'object',
                    properties: {
                      name: { type: 'string', analyzer: 'english_analyzer' },
                      address: { type: 'string', index: 'not_analyzed' },
                      city: { type: 'string', index: 'not_analyzed' },
                      state: { type: 'string', index: 'not_analyzed' },
                      country: { type: 'string', index: 'not_analyzed' }
                    }
                  }
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
