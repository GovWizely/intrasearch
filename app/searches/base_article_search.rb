require 'base_article_search_query'
require 'base_article_search_response'
require 'country_commercial_guide'
require 'market_insight'
require 'repository'
require 'search'
require 'state_report'
require 'top_markets_report'

class BaseArticleSearch
  attr_reader :count,
              :countries,
              :industries,
              :limit,
              :next_offset,
              :offset,
              :q,
              :topics,
              :total,
              :trade_regions,
              :types,
              :world_regions

  def initialize(options)
    @countries = options[:countries].to_s.split(',')
    @industries = options[:industries].to_s.split(',')
    @limit = options[:limit] || Search::DEFAULT_LIMIT
    @offset = options[:offset] || Search::DEFAULT_OFFSET
    @q = options[:q]
    @topics = options[:topics].to_s.split(',')
    @trade_regions = options[:trade_regions].to_s.split(',')
    @types = options[:types]
    @world_regions = options[:world_regions].to_s.split(',')
  end

  def run
    repository = Repository.new @types
    results = repository.search build_query
    BaseArticleSearchResponse.new self, results
  end

  def build_query
    BaseArticleSearchQuery.new(countries: @countries,
                           industries: @industries,
                           limit: @limit,
                           offset: @offset,
                           q: @q,
                           topics: @topics,
                           trade_regions: @trade_regions,
                           world_regions: @world_regions)
  end
end
