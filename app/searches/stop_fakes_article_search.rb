require 'article'
require 'base_article_search'
require 'stop_fakes_article_search_query'
require 'stop_fakes_article_search_response'

class StopFakesArticleSearch
  include BaseArticleSearch

  TYPES = [
    Article
  ].freeze

  self.query_class = StopFakesArticleSearchQuery
  self.search_response_class = StopFakesArticleSearchResponse

  def initialize(options)
    options[:types] = TYPES
    super
  end
end
