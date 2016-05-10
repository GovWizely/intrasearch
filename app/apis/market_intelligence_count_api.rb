require 'market_intelligence_search'

class MarketIntelligenceCountAPI < Grape::API
  version 'v1'

  %w(/market_intelligence_articles/count /articles/count).each do |path|
    get path do
      MarketIntelligenceSearch.new(search_type: :count).run
    end
  end
end
