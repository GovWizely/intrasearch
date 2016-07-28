require 'shared_params'
require 'privacy_shield_article_search'

class PrivacyShieldArticleCountAPI < Grape::API
  version 'v1'

  get '/privacy_shield_articles/count' do
    PrivacyShieldArticleSearch.new(search_type: :count).run
  end
end
