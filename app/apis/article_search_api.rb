require 'article_search'
require 'search'

class ArticleSearchAPI < Grape::API
  version 'v1'

  params do
    optional :countries, type: String
    optional :industries, type: String
    optional :q, type: String
    optional :topics, type: String
    optional :trade_regions, type: String
    optional :types, type: String
    at_least_one_of :countries,
                    :industries,
                    :q,
                    :topics,
                    :trade_regions,
                    :types

    optional :limit,
             type: Integer,
             values: 1..Search::MAX_LIMIT
    optional :offset,
             type: Integer,
             values: Search::DEFAULT_OFFSET..Search::MAX_OFFSET
  end

  get '/articles/search' do
    ArticleSearch.new(declared(params)).run
  end
end
