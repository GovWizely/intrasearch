require 'web_page_json_serializer'

module WebDocumentJSONSerializer
  extend WebPageJSONSerializer

  self.extra_attributes = {
    url: {
      key: :url
    }
  }

  self.snippet_attribute = :content
end
