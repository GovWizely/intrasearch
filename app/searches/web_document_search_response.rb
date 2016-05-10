require 'search_response'

class WebDocumentSearchResponse
  include SearchResponse

  def as_json(options = nil)
    super do |run_results|
      run_results[:aggregations] = build_aggregations if @search.search_type_count?
    end
  end
end
