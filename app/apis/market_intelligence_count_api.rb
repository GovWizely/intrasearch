require 'market_intelligence_search'

class MarketIntelligenceCountAPI < Grape::API
  version 'v1'

  %w(/market_intelligence_articles/count /articles/count).each do |path|
    get path do
      MarketIntelligenceSearch.new(limit: 0).run
    end
  end
end
