require 'admin/trade_event_find_by_id_api'
require 'admin/trade_event_list_api'
require 'admin/trade_event_update_api'

module Admin
  class TradeEventsAPI < Grape::API
    prefix :admin

    mount TradeEventFindByIdAPI
    mount TradeEventUpdateAPI
    mount TradeEventListAPI
  end
end
