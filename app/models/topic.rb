require 'taxonomy'

class Topic
  include Taxonomy
  attribute :path, String, mapping: { index: 'not_analyzed' }
end
