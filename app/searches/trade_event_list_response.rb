require 'list_response'
require 'trade_event_show_all_json_serializer'

class TradeEventListResponse
  include ListResponse

  self.serializer = TradeEventShowAllJSONSerializer
end
