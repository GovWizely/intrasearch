require 'base_article_extractor'
require 'extractable'

module ArticleExtractor
  extend Extractable
  self.api_name = 'Article__kav'.freeze
  extend BaseArticleExtractor
end
