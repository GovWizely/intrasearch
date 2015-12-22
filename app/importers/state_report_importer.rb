require 'article_importer'
require 'state_report'
require 'state_report_extractor'
require 'state_report_transformer'

class StateReportImporter < ArticleImporter
  self.extractor_module = StateReportExtractor
  self.model_class = StateReport
  self.transformer_class = StateReportTransformer
end
