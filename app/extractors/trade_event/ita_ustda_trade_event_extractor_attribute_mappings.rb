module TradeEvent
  module ItaUstdaTradeEventExtractorAttributeMappings
    def self.extended(base)
      base.module_eval do
        attribute :cost
        attribute :description
        attribute :end_date
        attribute :event_url, key: 'url'
        attribute :id
        attribute :industries, key: 'ita_industries'
        attribute :name, key: 'event_name'
        attribute :registration_title
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
  end
end
