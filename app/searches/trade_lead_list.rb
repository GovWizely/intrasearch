require 'list_with_extra'
require 'trade_lead/extra'
require 'trade_lead_list_response'
require 'trade_lead_match_all_query'
require 'trade_lead_repository'

class TradeLeadList
  include ListWithExtra

  self.extra_model_class = TradeLead::Extra
  self.query_class = TradeLeadMatchAllQuery
  self.repository_class = TradeLeadRepository
  self.response_class = TradeLeadListResponse
end
