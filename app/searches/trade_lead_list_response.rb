require 'list_response'
require 'trade_lead_show_all_json_serializer'

class TradeLeadListResponse
  include ListResponse

  self.serializer = TradeLeadShowAllJSONSerializer
end
