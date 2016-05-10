require 'how_to_article_search'

class HowToExportArticleCountAPI < Grape::API
  version 'v1'

  get '/how_to_export_articles/count' do
    HowToArticleSearch.new(search_type: :count).run
  end
end
