require 'webservices/trade_event'

require 'resource_extractor'

module TradeEvent
  module TradeEventExtractor
    def self.extended(base)
      base.extend ResourceExtractor

      base.keys_options_path = 'config/trade_event_extractor_keys_options.yml'
      base.resource = Webservices::TradeEvent
    end
  end
end
