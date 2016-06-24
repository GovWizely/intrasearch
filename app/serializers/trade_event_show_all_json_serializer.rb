require 'trade_event_show_json_serializer'

module TradeEventShowAllJSONSerializer
  extend TradeEventShowJSONSerializer

  attribute :description
  attribute :md_description, method: :md_description
  attribute :html_description, method: :html_description
end
