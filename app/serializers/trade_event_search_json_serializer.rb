require 'web_page_json_serializer'

module TradeEventSearchJSONSerializer
  extend WebPageJSONSerializer

  self.extra_attributes = {
    url: {
      key: :url
    }
  }

  self.snippet_attribute = :description
  self.title_attribute = :name
end
