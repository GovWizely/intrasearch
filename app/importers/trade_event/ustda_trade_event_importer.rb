require 'trade_event/trade_event_importer'
require 'trade_event/ustda_trade_event'
require 'trade_event/ustda_trade_event_extractor'
require 'ustda_trade_event_transformer'

module TradeEvent
  module UstdaTradeEventImporter
    extend TradeEventImporter
    self.transformer = UstdaTradeEventTransformer
  end
end
