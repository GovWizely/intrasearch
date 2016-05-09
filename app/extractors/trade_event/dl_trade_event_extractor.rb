require 'trade_event/trade_event_extractor'

module TradeEvent
  module DlTradeEventExtractor
    extend TradeEventExtractor

    attribute :description
    attribute :event_url, key: 'url'
    attribute :id
    attribute :name, key: 'event_name'
    attribute :source
  end
end
