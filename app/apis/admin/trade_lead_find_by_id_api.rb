require 'find_by_id_api'
require 'trade_lead'
require 'trade_lead_show_all_json_serializer'

module Admin
  class TradeLeadFindByIdAPI < Grape::API
    helpers do
      def serializer
        TradeLeadShowAllJSONSerializer
      end
    end

    extend FindByIdAPI
  end
end

