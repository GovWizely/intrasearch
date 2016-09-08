require 'trade_event_search_response'
require 'trade_event_show_json_serializer'

class TradeEventFieldsSearchResponse < TradeEventSearchResponse
  self.serializer = TradeEventShowJSONSerializer
end
