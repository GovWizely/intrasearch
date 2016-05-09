require 'search_response'
require 'web_document_json_serializer'

class WebDocumentSearchResponse
  include SearchResponse

  self.serializer = WebDocumentJSONSerializer

  def as_json(options = nil)
    super do |run_results|
      run_results[:aggregations] = build_aggregations if @search.search_type_count?
    end
  end
end
