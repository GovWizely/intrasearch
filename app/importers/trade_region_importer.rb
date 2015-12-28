require 'base_importer'
require 'trade_region'
require 'trade_region_extractor'

class TradeRegionImporter < BaseImporter
  ROOT_LABEL = 'Trade Regions'.freeze

  self.model_class = TradeRegion

  def initialize(resource = Nix.root.join('skos/regions.owl.xml'))
    @resource = resource
  end

  def import
    super do
      TradeRegionExtractor.documents(@resource).each do |trade_region_hash|
        model_class.create trade_region_hash
      end
    end
  end
end
