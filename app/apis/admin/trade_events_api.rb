require 'trade_event_find_by_id_api'
require 'trade_event_list_api'

module Admin
  class TradeEventsAPI < Grape::API
    prefix :admin

    mount TradeEventListAPI
    extend TradeEventFindByIdAPI
  end
end
