require 'find_by_id_api'
require 'trade_lead'
require 'trade_lead_show_json_serializer'

class TradeLeadFindByIdAPI < Grape::API
  helpers do
    def serializer
      TradeLeadShowJSONSerializer
    end
  end

  extend FindByIdAPI
end
