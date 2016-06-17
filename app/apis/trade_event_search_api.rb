require 'shared_params'
require 'trade_event'

class TradeEventSearchAPI < Grape::API
  helpers SharedParams

  params do
    use :pagination
    optional :countries, type: String
    optional :industries, type: String
    optional :q, type: String
    optional :trade_regions, type: String
    optional :world_regions, type: String
    at_least_one_of :countries,
                    :industries,
                    :q,
                    :trade_regions,
                    :world_regions
  end

  get '/trade_events/search' do
    TradeEvent.search declared(params)
  end
end
