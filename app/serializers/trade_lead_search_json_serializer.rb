require 'web_page_json_serializer'

module TradeLeadSearchJSONSerializer
  extend WebPageJSONSerializer

  self.extra_attributes = {
    url: {
      key: :hosted_url
    }
  }

  self.snippet_attribute = :description
end
