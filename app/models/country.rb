require 'taxonomy'
require 'taxonomy_search_methods'

class Country
  include Taxonomy
  extend TaxonomySearchMethods
  attribute :trade_regions, String, mapping: { analyzer: 'keyword_analyzer' }
  attribute :world_region_paths, String, mapping: { index: 'not_analyzed' }
  attribute :world_regions, String, mapping: { analyzer: 'keyword_analyzer' }
end
