require 'search'

module SharedParams
  extend Grape::API::Helpers

  params :base_article do
    optional :countries, type: String
    optional :industries, type: String
    optional :q, type: String
    optional :topics, type: String
    optional :trade_regions, type: String
    optional :world_regions, type: String
    at_least_one_of :countries,
                    :industries,
                    :q,
                    :topics,
                    :trade_regions,
                    :world_regions
  end

  params :pagination do
    optional :limit,
             type: Integer,
             values: 1..Search::MAX_LIMIT
    optional :offset,
             type: Integer,
             values: Search::DEFAULT_OFFSET..Search::MAX_OFFSET
  end

  params :full_text_search_with_countries_and_industries do
    optional :countries, type: String
    optional :industries, type: String
    optional :q, type: String
  end
end
