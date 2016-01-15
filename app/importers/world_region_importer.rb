require 'region_importer'
require 'world_region'
require 'world_region_extractor'

module WorldRegionImporter
  extend RegionImporter

  self.extractor = WorldRegionExtractor
  self.model_class = WorldRegion
end
