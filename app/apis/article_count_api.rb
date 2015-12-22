require 'article_search'

class ArticleCountAPI < Grape::API
  version 'v1'

  get '/articles/count' do
    ArticleSearch.new(search_type: :count).run
  end
end
