require 'trade_event/base_model'
require 'trade_event/ita_ustda_trade_event_attributes'

module TradeEvent
  class ItaTradeEvent
    include BaseModel
    include ItaUstdaTradeEventAttributes

    not_analyzed_attributes :event_type
  end
end
