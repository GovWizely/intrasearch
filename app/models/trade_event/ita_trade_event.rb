require 'trade_event/base_trade_event_model'
require 'trade_event/ita_ustda_trade_event_attributes'

module TradeEvent
  class ItaTradeEvent
    include BaseTradeEventModel
    include ItaUstdaTradeEventAttributes
  end
end
