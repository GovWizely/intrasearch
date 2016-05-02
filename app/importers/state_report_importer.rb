require 'base_article_importer'
require 'state_report'
require 'state_report_extractor'
require 'state_report_transformer'

module StateReportImporter
  extend BaseArticleImporter

  self.transformer = StateReportTransformer
end
