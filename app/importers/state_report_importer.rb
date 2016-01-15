require 'article_importer'
require 'state_report'
require 'state_report_extractor'
require 'state_report_transformer'

module StateReportImporter
  extend ArticleImporter

  self.extractor = StateReportExtractor
  self.model_class = StateReport
  self.transformer = StateReportTransformer
end
