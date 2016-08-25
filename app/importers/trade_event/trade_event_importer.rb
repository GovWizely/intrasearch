require 'common_importer'
require 'importer_descendants_tracker'
require 'trade_event_transformer'

module TradeEvent
  module TradeEventImporter
    extend ImporterDescendantsTracker

    def self.extended(base)
      self.track_descendant base
      base.extend CommonImporter
      base.transformer = TradeEventTransformer
    end
  end
end
