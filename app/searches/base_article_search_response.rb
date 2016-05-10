require 'search_response'

class BaseArticleSearchResponse
  include SearchResponse

  def as_json(options = nil)
    super do |run_results|
      run_results[:aggregations] = build_aggregations
    end
  end
end
