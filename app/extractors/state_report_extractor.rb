require 'restforce'

require 'article_extractor'
require 'extractable'

module StateReportExtractor
  extend Extractable
  self.api_name = 'State_Report__kav'.freeze
  extend ArticleExtractor
end
