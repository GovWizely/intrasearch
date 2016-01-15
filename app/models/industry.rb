require 'taxonomy'

class Industry
  include Taxonomy
  attribute :path, String, mapping: { index: 'not_analyzed' }
end
