require 'trade_lead_count_api'
require 'trade_lead_find_by_id_api'
require 'trade_lead_search_api'

class TradeLeadsAPI < Grape::API
  version 'v1'

  mount TradeLeadCountAPI
  mount TradeLeadSearchAPI
  mount TradeLeadFindByIdAPI
end
