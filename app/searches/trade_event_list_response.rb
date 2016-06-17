require 'list_response'
require 'trade_event_show_json_serializer'

class TradeEventListResponse
  include ListResponse

  self.serializer = TradeEventShowJSONSerializer
end
