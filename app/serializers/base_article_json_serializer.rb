require 'web_page_json_serializer'

module BaseArticleJSONSerializer
  extend WebPageJSONSerializer

  self.extra_attributes = {
    id: {
      key: :id
    },
    url: {
      key: :url
    }
  }

  self.snippet_attribute = :atom
end
