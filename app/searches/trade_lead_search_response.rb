require 'search_response'
require 'trade_lead_search_json_serializer'

class TradeLeadSearchResponse
  include SearchResponse

  self.serializer = TradeLeadSearchJSONSerializer

  def as_json(options = nil)
    super do |run_results|
      run_results[:aggregations] = build_aggregations
    end
  end
end
