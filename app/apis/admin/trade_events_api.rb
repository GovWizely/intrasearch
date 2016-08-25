require 'admin/get_trade_events_api'
require 'admin/trade_event_find_by_id_api'
require 'admin/update_trade_event_api'

module Admin
  class TradeEventsAPI < Grape::API
    prefix :admin

    mount GetTradeEventsAPI
    mount UpdateTradeEventAPI
    mount TradeEventFindByIdAPI
  end
end
