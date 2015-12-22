require 'restforce'

require 'article_extractor'
require 'extractable'

module TopMarketsReportExtractor
  extend Extractable
  self.api_name = 'Top_Markets__kav'.freeze
  extend ArticleExtractor
end
