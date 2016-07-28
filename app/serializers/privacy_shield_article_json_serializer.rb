require 'article_json_serializer'

module PrivacyShieldArticleJSONSerializer
  extend ArticleJSONSerializer

  self.url_prefix = Intrasearch.config['privacy_shield_article_url_prefix'].freeze
end
