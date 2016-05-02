require 'base_article_extractor'
require 'extractable'

module MarketInsightExtractor
  extend Extractable
  self.api_name = 'Market_Insight__kav'.freeze
  extend BaseArticleExtractor
end
