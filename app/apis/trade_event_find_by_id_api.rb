require 'find_by_id_api'
require 'trade_event'
require 'trade_event_show_json_serializer'

class TradeEventFindByIdAPI < Grape::API
  helpers do
    def serializer
      TradeEventShowJSONSerializer
    end
  end

  extend FindByIdAPI
end
