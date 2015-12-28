require 'trade_region_search_by_country_query'

module TradeRegionSearch
  def search_by_countries(*countries)
    query = TradeRegionSearchByCountryQuery.new countries
    self.search query.to_hash
  end
end
