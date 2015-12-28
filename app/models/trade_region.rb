require 'taxonomy'
require 'trade_region_search'

class TradeRegion
  include Taxonomy
  extend TradeRegionSearch

  attribute :countries, String, mapping: { analyzer: 'keyword_analyzer' }
end
