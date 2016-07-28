require 'article'
require 'article_search_query'
require 'base_article_search'

module ArticleSearch
  TYPES = [
    Article
  ].freeze

  def self.included(base)
    base.include BaseArticleSearch
    base.include InstanceMethods

    base.query_class = ArticleSearchQuery

    class << base
      attr_accessor :guides
    end
  end

  module InstanceMethods
    def initialize(options)
      options[:types] = TYPES
      super
    end

    def query_params
      params = super
      params[:guides] = self.class.guides
      params
    end
  end
end
