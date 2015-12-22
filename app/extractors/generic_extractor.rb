require 'restforce'

require 'article_extractor'
require 'extractable'

module GenericExtractor
  extend Extractable
  self.api_name = 'Generic__kav'.freeze
  extend ArticleExtractor
end
