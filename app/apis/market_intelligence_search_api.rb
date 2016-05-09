require 'market_intelligence_search'
require 'shared_params'

class MarketIntelligenceSearchAPI < Grape::API
  helpers SharedParams
  version 'v1'

  %i(market_intelligence_articles articles).each do |ns|
    namespace ns do
      params do
        use :base_article, :pagination
      end

      get '/search'do
        MarketIntelligenceSearch.new(declared(params)).run
      end
    end
  end
end
