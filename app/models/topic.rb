require 'taxonomy'
require 'taxonomy_search'

class Topic
  include Taxonomy
  extend TaxonomySearch
end
