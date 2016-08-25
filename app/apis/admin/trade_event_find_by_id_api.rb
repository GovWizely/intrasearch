require 'find_by_id_api'
require 'trade_event'
require 'trade_event_show_all_json_serializer'

module Admin
  class TradeEventFindByIdAPI < Grape::API
    helpers do
      def serializer
        TradeEventShowAllJSONSerializer
      end
    end

    extend FindByIdAPI
  end
end

