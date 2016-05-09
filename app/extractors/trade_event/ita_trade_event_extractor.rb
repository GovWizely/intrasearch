require 'trade_event/ita_ustda_trade_event_extractor_attribute_mappings'
require 'trade_event/trade_event_extractor'

module TradeEvent
  module ItaTradeEventExtractor
    extend TradeEventExtractor
    extend ItaUstdaTradeEventExtractorAttributeMappings
  end
end
