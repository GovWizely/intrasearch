require 'web_page_json_serializer'

module TradeEventSearchJSONSerializer
  extend WebPageJSONSerializer

  self.extra_attributes = {
    id: {
      key: :id
    },
    url: {
      key: :hosted_url
    }
  }

  self.snippet_attribute = :original_description
  self.title_attribute = :name
end
