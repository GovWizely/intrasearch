require 'trade_region'
require 'world_region'

module CountryTransformer
  def self.transform(country_hash)
    trade_regions = TradeRegion.search_by_countries country_hash[:label]
    country_hash[:trade_regions] = trade_regions.map(&:label)

    world_regions = WorldRegion.search_by_countries country_hash[:label]
    country_hash[:world_regions] = world_regions.map(&:label)
  end
end
