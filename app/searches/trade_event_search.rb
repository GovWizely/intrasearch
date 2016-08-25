require 'filter_by_countries_industries_search'
require 'trade_event_repository'
require 'trade_event_search_query'
require 'trade_event_search_response'

class TradeEventSearch
  include FilterByCountriesIndustriesSearch

  self.repository_class = TradeEventRepository
  self.search_response_class = TradeEventSearchResponse
  self.query_class = TradeEventSearchQuery
end
