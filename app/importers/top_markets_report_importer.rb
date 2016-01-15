require 'article_importer'
require 'top_markets_report'
require 'top_markets_report_extractor'

module TopMarketsReportImporter
  extend ArticleImporter

  self.extractor = TopMarketsReportExtractor
  self.model_class = TopMarketsReport
end
