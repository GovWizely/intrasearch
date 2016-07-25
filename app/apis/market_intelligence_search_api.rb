require 'base_article_search_api'
require 'market_intelligence_search'

class MarketIntelligenceSearchAPI < Grape::API
  extend BaseArticleSearchAPI
  version 'v1'

  get '/market_intelligence_articles/search'do
    MarketIntelligenceSearch.new(declared(params)).run
  end
end
