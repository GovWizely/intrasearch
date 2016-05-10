require 'active_support/core_ext/string/inflections'

require 'base_article_attributes'
require 'base_model'
require 'web_page_json_serializer'

module BaseArticle
  def self.included(base)
    base.class_eval do
      include BaseModel
      include BaseArticleAttributes
      include WebPageJSONSerializer

      self.snippet_field = :atom
      self.extra_json_fields |= %i(id)

      self.index_name_prefix = ['intrasearch',
                                Intrasearch.env,
                                'articles',
                                name.tableize,
                                'v1'].join('-').freeze

      self.index_alias_name = ['intrasearch',
                               Intrasearch.env,
                               'articles',
                               name.tableize,
                               'current'].join('-').freeze

      self.reset_index_name!
    end
  end
end
