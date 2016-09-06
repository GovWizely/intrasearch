require 'trade_event/base_model'
require 'trade_event/ita_ustda_trade_event_attributes'

module TradeEvent
  class UstdaTradeEvent
    include BaseModel
    include ItaUstdaTradeEventAttributes

    not_analyzed_attributes :cost_currency,
                            :end_time,
                            :start_time
  end
end
