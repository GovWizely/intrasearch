require 'base_article_search_api'
require 'how_to_export_article_search'

class HowToExportArticleSearchAPI < Grape::API
  extend BaseArticleSearchAPI
  version 'v1'

  get '/how_to_export_articles/search' do
    HowToExportArticleSearch.new(declared(params)).run
  end
end
