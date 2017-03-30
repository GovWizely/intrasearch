require 'base_article_extractor'
require 'extractable'

module MarketIntelligenceExtractor
  extend Extractable
  self.api_name = 'Market_Intelligence__kav'.freeze
  extend BaseArticleExtractor
end
