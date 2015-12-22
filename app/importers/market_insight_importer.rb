require 'article_importer'
require 'market_insight'
require 'market_insight_extractor'

class MarketInsightImporter < ArticleImporter
  self.extractor_module = MarketInsightExtractor
  self.model_class = MarketInsight
end
