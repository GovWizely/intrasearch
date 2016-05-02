require 'base_article_extractor'
require 'extractable'

module FaqExtractor
  extend Extractable
  self.api_name = 'FAQ__kav'.freeze
  extend BaseArticleExtractor
end
