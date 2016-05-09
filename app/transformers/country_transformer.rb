require 'taxonomy_attributes_transformer'
require 'trade_region'
require 'world_region'

module CountryTransformer
  extend TaxonomyAttributesTransformer

  def self.transform(country_hash)
    trade_regions = TradeRegion.search_by_countries country_hash[:label]
    country_hash[:trade_regions] = trade_regions.map(&:label).sort

    world_regions = WorldRegion.search_by_countries country_hash[:label]
    country_hash[:world_region_paths] = world_regions.map(&:path).sort
    country_hash[:world_regions] = paths_to_labels world_regions.map(&:path).sort
  end
end
