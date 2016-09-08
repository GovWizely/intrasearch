require 'filter_by_countries_industries_search'
require 'trade_lead_repository'
require 'trade_lead_search_query'

class TradeLeadSearch
  include FilterByCountriesIndustriesSearch
  self.repository_class = TradeLeadRepository
  self.query_class = TradeLeadSearchQuery
end
