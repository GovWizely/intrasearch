require 'active_support/core_ext/string/inflections'
require 'forwardable'

require 'base_model'
require 'trade_event/trade_event_extra'

module TradeEvent
  module BaseTradeEventModel
    def self.included(base)
      base.include BaseModel
      base.extend Forwardable
      base.def_delegators :extra, :md_description, :html_description

      base.attribute :start_date,
                     Date,
                     mapping: {
                       format: 'strict_date',
                       index: 'not_analyzed'
                     }

      base.class_eval do
        append_index_namespace parent.name.tableize,
                               name.demodulize.tableize
      end
    end

    def update_extra_attributes(extra_attributes)
      @extra = TradeEventExtra.create extra_attributes.merge id: id
      @extra.persisted?
    end

    def extra
      load_extra unless @extra
      @extra
    end

    private

    def load_extra
      @extra = begin
        TradeEventExtra.find id
      rescue Elasticsearch::Persistence::Repository::DocumentNotFound
        TradeEventExtra.new
      end
    end

    def display_description
      extra.html_description.present? ? extra.html_description : description
    end
  end
end
