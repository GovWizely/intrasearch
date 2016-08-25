require 'filter_by_countries_industries_search'
require 'trade_lead_repository'
require 'trade_lead_search_query'
require 'trade_lead_search_response'

class TradeLeadSearch
  include FilterByCountriesIndustriesSearch
  self.repository_class = TradeLeadRepository
  self.search_response_class = TradeLeadSearchResponse
  self.query_class = TradeLeadSearchQuery
end
