require 'region_importer'
require 'trade_region'
require 'trade_region_extractor'

module TradeRegionImporter
  extend RegionImporter

  self.extractor = TradeRegionExtractor
  self.model_class = TradeRegion
end
