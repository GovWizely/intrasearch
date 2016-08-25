require 'common_importer'
require 'importer_descendants_tracker'
require 'trade_lead_transformer'

module TradeLead
  module TradeLeadImporter
    extend ImporterDescendantsTracker

    def self.extended(base)
      self.track_descendant base
      base.extend CommonImporter
      base.transformer = TradeLeadTransformer
    end
  end
end
