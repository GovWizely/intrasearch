require 'base_article_search_api'
require 'stop_fakes_article_search'

class StopFakesArticleSearchAPI < Grape::API
  extend BaseArticleSearchAPI
  version 'v1'

  get '/stop_fakes_articles/search' do
    StopFakesArticleSearch.new(declared(params)).run
  end
end
