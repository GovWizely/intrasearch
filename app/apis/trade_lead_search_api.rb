require 'filter_by_countries_industries_search_api'
require 'trade_lead'

class TradeLeadSearchAPI < Grape::API
  extend FilterByCountriesIndustriesSearchAPI

  params do
    at_least_one_of :countries,
                    :industries,
                    :q
  end

  get '/trade_leads/search' do
    TradeLead.search declared(params)
  end
end
