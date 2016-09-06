require 'trade_event/base_model'

module TradeEvent
  class DlTradeEvent
    include BaseModel

    not_analyzed_attributes :url

    def as_json(options = nil)
      options ||= {}
      options[:except] ||= []
      options[:except] |= [:start_date]
      super
    end
  end
end
