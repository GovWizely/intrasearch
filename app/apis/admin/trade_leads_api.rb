require 'admin/trade_lead_find_by_id_api'
require 'admin/trade_lead_list_api'
require 'admin/trade_lead_update_api'

module Admin
  class TradeEventsAPI < Grape::API
    prefix :admin

    mount TradeLeadFindByIdAPI
    mount TradeLeadUpdateAPI
    mount TradeLeadListAPI
  end
end
