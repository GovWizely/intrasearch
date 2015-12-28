require 'active_support/core_ext/string/inflections'
require 'elasticsearch/persistence/model'

require 'article_attributes'
require 'article_json_serializer'
require 'base_model'

module Article
  def self.included(base)
    base.class_eval do
      include Elasticsearch::Persistence::Model
      include BaseModel
      include ArticleAttributes
      include ArticleJsonSerializer

      self.index_name_fragments = ['nix',
                                   Nix.env,
                                   'articles',
                                   self.name.tableize,
                                   'current'].freeze

      self.reset_index_name!

      def attributes
        super.stringify_keys!
      end
    end
  end
end
