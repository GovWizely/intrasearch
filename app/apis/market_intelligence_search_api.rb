require 'base_article_search_api'
require 'market_intelligence_search'

class MarketIntelligenceSearchAPI < Grape::API
  version 'v1'

  %i(market_intelligence_articles articles).each do |ns|
    namespace ns do
      BaseArticleSearchAPI.declare_search_params self

      get '/search'do
        MarketIntelligenceSearch.new(declared(params)).run
      end
    end
  end
end
