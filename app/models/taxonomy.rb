require 'active_support/core_ext/string/inflections'

require 'base_model'
require 'taxonomy_search_methods'

module Taxonomy
  def self.included(base)
    base.class_eval do
      include BaseModel
      extend TaxonomySearchMethods

      attribute :label, String, mapping: { analyzer: 'keyword_analyzer' }

      self.index_name_prefix = ['intrasearch',
                                Intrasearch.env,
                                'taxonomies',
                                name.tableize,
                                'v1'].join('-').freeze

      self.index_alias_name = ['intrasearch',
                               Intrasearch.env,
                               'taxonomies',
                               name.tableize,
                               'current'].join('-').freeze

      self.reset_index_name!
    end
  end
end
