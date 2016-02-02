require 'region'

class WorldRegion
  include Region
  attribute :path, String, mapping: { index: 'not_analyzed' }
end
