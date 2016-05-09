require 'search_response'
require 'trade_event_search_json_serializer'

class TradeEventSearchResponse
  include SearchResponse

  self.serializer = TradeEventSearchJSONSerializer

  def as_json(options = nil)
    super do |run_results|
      run_results[:aggregations] = build_aggregations
    end
  end
end
