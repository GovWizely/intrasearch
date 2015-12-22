require 'article_importer'
require 'top_markets_report'
require 'top_markets_report_extractor'

class TopMarketsReportImporter < ArticleImporter
  self.extractor_module = TopMarketsReportExtractor
  self.model_class = TopMarketsReport
end
