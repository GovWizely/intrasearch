require 'market_intelligence_search'

class MarketIntelligenceCountAPI < Grape::API
  version 'v1'

  get '/market_intelligence_articles/count' do
    MarketIntelligenceSearch.new(search_type: :count).run
  end
end
