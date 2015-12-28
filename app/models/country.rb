require 'taxonomy'
require 'taxonomy_search'

class Country
  include Taxonomy
  extend TaxonomySearch
  attribute :trade_regions, String, mapping: { analyzer: 'keyword_analyzer' }
end
