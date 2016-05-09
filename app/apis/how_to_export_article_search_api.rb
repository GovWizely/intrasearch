require 'how_to_article_search'
require 'shared_params'

class HowToExportArticleSearchAPI < Grape::API
  helpers SharedParams
  version 'v1'

  params do
    use :base_article, :pagination
  end

  get '/how_to_export_articles/search' do
    HowToArticleSearch.new(declared(params)).run
  end
end
