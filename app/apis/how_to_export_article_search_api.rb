require 'base_article_search_api'
require 'how_to_article_search'

class HowToExportArticleSearchAPI < Grape::API
  version 'v1'
  BaseArticleSearchAPI.declare_search_params self

  get '/how_to_export_articles/search' do
    HowToArticleSearch.new(declared(params)).run
  end
end
