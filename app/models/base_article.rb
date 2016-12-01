require 'active_support/core_ext/string/inflections'

require 'base_article_attributes'
require 'base_model'

module BaseArticle
  def self.included(base)
    base.class_eval do
      include BaseModel
      include BaseArticleAttributes

      append_index_namespace 'articles',
                             name.tableize
    end
  end
end
