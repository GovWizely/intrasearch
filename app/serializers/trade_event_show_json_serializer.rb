require 'show_json_serializer'

module TradeEventShowJSONSerializer
  extend ShowJSONSerializer

  attribute :id
  attribute :name
  attribute :url
  attribute :source
  attribute :event_url
  attribute :description
  attribute :cost
  attribute :registration_title
  attribute :registration_url
  attribute :start_date
  attribute :end_date
  attribute :countries, default: []
  attribute :industries, default: []
  attribute :trade_regions, default: []
  attribute :world_regions, default: []
end
