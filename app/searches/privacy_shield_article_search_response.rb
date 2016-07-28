require 'base_article_search_response'
require 'privacy_shield_article_json_serializer'

class PrivacyShieldArticleSearchResponse < BaseArticleSearchResponse
  self.serializer = PrivacyShieldArticleJSONSerializer
end
