require 'article_search'
require 'privacy_shield_article_search_response'

class PrivacyShieldArticleSearch
  include ArticleSearch

  self.guides = [
    'privacy shield framework',
    'privacy shield program',
  ].freeze

  self.search_response_class = PrivacyShieldArticleSearchResponse
end
