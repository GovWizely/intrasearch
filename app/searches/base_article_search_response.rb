require 'base_article_json_serializer'
require 'search_response'

class BaseArticleSearchResponse
  include SearchResponse

  self.serializer = BaseArticleJSONSerializer

  def as_json(options = nil)
    super do |run_results|
      run_results[:aggregations] = build_aggregations
    end
  end
end
