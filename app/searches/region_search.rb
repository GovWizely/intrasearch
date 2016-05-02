require 'region_search_by_country_query'

module RegionSearch
  def search_by_countries(*countries)
    query = RegionSearchByCountryQuery.new countries
    search query.to_hash
  end
end
