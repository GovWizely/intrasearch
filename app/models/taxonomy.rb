require 'active_support/core_ext/string/inflections'
require 'elasticsearch/persistence/model'

require 'base_model'
require 'taxonomy_search_methods'

module Taxonomy
  def self.included(base)
    base.class_eval do
      include Elasticsearch::Persistence::Model
      include BaseModel
      extend TaxonomySearchMethods

      attribute :label, String, mapping: { analyzer: 'keyword_analyzer' }

      self.index_name_prefix = ['nix',
                                Nix.env,
                                'taxonomies',
                                'v2',
                                self.name.tableize].join('-').freeze

      self.index_name_fragments = [index_name_prefix,
                                   'current'].freeze

      self.index_alias_name = ['nix',
                               Nix.env,
                               'taxonomies',
                               self.name.tableize,
                               'current'].join('-').freeze

      self.reset_index_name!
    end
  end
end
