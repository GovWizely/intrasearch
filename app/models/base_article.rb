require 'active_support/core_ext/string/inflections'
require 'elasticsearch/persistence/model'

require 'base_article_attributes'
require 'base_article_json_serializer'
require 'base_model'

module BaseArticle
  def self.included(base)
    base.class_eval do
      include Elasticsearch::Persistence::Model
      include BaseModel
      include BaseArticleAttributes
      include BaseArticleJsonSerializer

      self.index_name_prefix = ['intrasearch',
                                Intrasearch.env,
                                'articles',
                                name.tableize].join('-').freeze

      self.index_name_fragments = [index_name_prefix,
                                   'current'].freeze

      self.index_alias_name = ['intrasearch',
                               Intrasearch.env,
                               'articles',
                               name.tableize,
                               'current'].join('-').freeze

      self.reset_index_name!

      def attributes
        super.stringify_keys!
      end
    end
  end
end
