require 'article'
require 'article_search'
require 'stop_fakes_article_search_response'

class StopFakesArticleSearch
  include ArticleSearch

  self.guides = %w(stopfakes).freeze

  self.search_response_class = StopFakesArticleSearchResponse
end
