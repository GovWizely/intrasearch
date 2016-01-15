require 'region_search'
require 'taxonomy'

module Region
  def self.included(base)
    base.class_eval do
      include Taxonomy
      extend RegionSearch

      attribute :countries, String, mapping: { analyzer: 'keyword_analyzer' }
    end
  end
end
