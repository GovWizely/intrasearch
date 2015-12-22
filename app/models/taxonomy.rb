require 'active_support/core_ext/string/inflections'
require 'elasticsearch/persistence/model'

require 'base_model'

module Taxonomy
  def self.included(base)
    base.class_eval do
      include Elasticsearch::Persistence::Model
      include BaseModel
      attribute :label, String, mapping: { analyzer: 'keyword_analyzer' }
      attribute :leaf_node, Axiom::Types::Boolean, mapping: { index: 'not_analyzed' }
      attribute :path, String, mapping: { index: 'not_analyzed' }

      self.index_name_fragments = ['nix',
                                   Nix.env,
                                   'taxonomies',
                                   self.name.tableize,
                                   'current'].freeze

      self.reset_index_name!
    end
  end
end
