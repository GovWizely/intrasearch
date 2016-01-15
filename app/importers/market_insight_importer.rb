require 'article_importer'
require 'market_insight'
require 'market_insight_extractor'

module MarketInsightImporter
  extend ArticleImporter

  self.extractor = MarketInsightExtractor
  self.model_class = MarketInsight
end
