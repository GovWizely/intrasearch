require 'base_article_search_api'
require 'privacy_shield_article_search'

class PrivacyShieldArticleSearchAPI < Grape::API
  extend BaseArticleSearchAPI
  version 'v1'

  get '/privacy_shield_articles/search' do
    PrivacyShieldArticleSearch.new(declared(params)).run
  end
end
