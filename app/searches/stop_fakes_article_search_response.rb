require 'base_article_search_response'
require 'stop_fakes_article_json_serializer'

class StopFakesArticleSearchResponse < BaseArticleSearchResponse
  self.serializer = StopFakesArticleJSONSerializer
end
