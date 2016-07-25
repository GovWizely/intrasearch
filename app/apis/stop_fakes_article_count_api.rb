require 'shared_params'
require 'stop_fakes_article_search'

class StopFakesArticleCountAPI < Grape::API
  version 'v1'

  get '/stop_fakes_articles/count' do
    StopFakesArticleSearch.new(search_type: :count).run
  end
end
