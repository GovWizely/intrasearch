require 'search'

module BaseArticleSearchAPI
  def self.declare_search_params(base)
    base.params do
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
                      :types,
                      :world_regions

      optional :limit,
               type: Integer,
               values: 1..Search::MAX_LIMIT
      optional :offset,
               type: Integer,
               values: Search::DEFAULT_OFFSET..Search::MAX_OFFSET
    end
  end
end
