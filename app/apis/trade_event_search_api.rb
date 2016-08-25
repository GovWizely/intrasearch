require 'filter_by_countries_industries_search_api'
require 'trade_event'

class TradeEventSearchAPI < Grape::API
  extend FilterByCountriesIndustriesSearchAPI

  get '/trade_events/search' do
    TradeEvent.search declared(params)
  end
end
