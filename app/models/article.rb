require 'active_support/core_ext/string/inflections'
require 'elasticsearch/persistence/model'

require 'article_json_serializer'
require 'base_model'

module Article
  def self.included(base)
    base.class_eval do
      include Elasticsearch::Persistence::Model
      include BaseModel
      include ArticleJsonSerializer

      attribute :atom, String, mapping: { analyzer: 'english_analyzer' }
      attribute :countries,
                String,
                mapping: {
                  analyzer: 'keyword_analyzer',
                  fields: {
                    raw: {
                      index: 'not_analyzed',
                      type: 'string'
                    }
                  }
                }
      attribute :industries, String, mapping: { index: 'not_analyzed' }
      attribute :industry_paths, String, mapping: { analyzer: 'path_analyzer' }
      attribute :summary, String, mapping: { analyzer: 'english_analyzer' }
      attribute :topic_paths, String, mapping: { analyzer: 'path_analyzer' }
      attribute :topics, String, mapping: { index: 'not_analyzed' }
      attribute :title, String, mapping: { analyzer: 'english_analyzer' }
      attribute :type,
                String,
                default: self.name.demodulize.titleize,
                mapping: { index: 'not_analyzed' }
      attribute :url, String, mapping: { index: 'not_analyzed' }

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
