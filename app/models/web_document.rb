require 'active_support/core_ext/string/inflections'

require 'base_model'
require 'web_page_json_serializer'

class WebDocument
  include BaseModel
  include WebPageJSONSerializer

  self.snippet_field = :content

  attribute :content, String, mapping: { analyzer: 'english_analyzer' }
  attribute :description, String, mapping: { analyzer: 'english_analyzer' }
  attribute :domain, String, mapping: { index: 'not_analyzed' }
  attribute :title, String, mapping: { analyzer: 'english_analyzer' }
  attribute :url, String, mapping: { index: 'not_analyzed' }

  validates :title, :url, presence: true

  self.index_name_prefix = ['intrasearch',
                            Intrasearch.env,
                            name.tableize,
                            'v1'].join('-').freeze

  self.index_alias_name = ['intrasearch',
                           Intrasearch.env,
                           name.tableize,
                           'current'].join('-').freeze

  self.reset_index_name!
end
