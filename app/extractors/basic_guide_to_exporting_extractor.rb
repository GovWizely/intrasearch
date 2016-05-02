require 'base_article_extractor'
require 'extractable'

module BasicGuideToExportingExtractor
  extend Extractable
  self.api_name = 'Basic_Guide_to_Exporting__kav'.freeze
  extend BaseArticleExtractor
end
