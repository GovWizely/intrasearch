require 'admin/get_trade_event_api'
require 'admin/get_trade_events_api'
require 'admin/update_trade_event_api'

module Admin
  class TradeEventsAPI < Grape::API
    prefix :admin

    mount GetTradeEventsAPI
    mount UpdateTradeEventAPI
    mount GetTradeEventAPI
  end
end
