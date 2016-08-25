require 'webservices/trade_lead'

require 'resource_extractor'

module TradeLead
  module TradeLeadExtractor
    def self.extended(base)
      base.extend ResourceExtractor

      base.keys_options_path = 'config/trade_lead_extractor_keys_options.yml'
      base.resource = Webservices::TradeLead
    end
  end
end
