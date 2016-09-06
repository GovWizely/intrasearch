require 'find_by_id_api'
require 'legacy_trade_event_show_json_serializer'
require 'trade_event'

module Legacy
  class TradeEventFindByIdAPI < Grape::API
    helpers do
      def serializer
        LegacyTradeEventShowJSONSerializer
      end
    end

    extend FindByIdAPI
  end
end
