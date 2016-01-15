require 'active_support/core_ext/string/inflections'
require 'elasticsearch/persistence/model'

require 'base_model'
require 'taxonomy_search'

module Taxonomy
  def self.included(base)
    base.class_eval do
      include Elasticsearch::Persistence::Model
      include BaseModel
      extend TaxonomySearch

      attribute :label, String, mapping: { analyzer: 'keyword_analyzer' }

      self.index_name_fragments = ['nix',
                                   Nix.env,
                                   'taxonomies',
                                   self.name.tableize,
                                   'current'].freeze

      self.reset_index_name!
    end
  end
end
