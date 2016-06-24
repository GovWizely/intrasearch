require 'trade_event'
require 'trade_event_find_by_id_api'
require 'trade_event_show_json_serializer'

class GetTradeEventAPI < Grape::API
  helpers do
    def serializer
      TradeEventShowJSONSerializer
    end
  end

  extend TradeEventFindByIdAPI
end
