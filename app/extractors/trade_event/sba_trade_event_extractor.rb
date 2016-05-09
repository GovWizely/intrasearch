require 'trade_event/trade_event_extractor'

module TradeEvent
  module SbaTradeEventExtractor
    extend TradeEventExtractor

    attribute :cost
    attribute :description
    attribute :end_date
    attribute :id
    attribute :industries, key: 'ita_industries'
    attribute :name, key: 'event_name'
    attribute :registration_url, key: 'registration_link'
    attribute :source
    attribute :start_date
    attribute :venues,
              attributes: [
                { country: { key: 'country_name' } },
                :venue
              ]
  end
end
