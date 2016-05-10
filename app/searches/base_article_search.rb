require 'base_article_search_query'
require 'base_article_search_response'
require 'repository'
require 'search'

class BaseArticleSearch
  include Search

  def initialize(options)
    super
    @countries = options[:countries].to_s.split(',')
    @industries = options[:industries].to_s.split(',')
    @topics = options[:topics].to_s.split(',')
    @trade_regions = options[:trade_regions].to_s.split(',')
    @types = options[:types]
    @world_regions = options[:world_regions].to_s.split(',')
  end

  def run
    repository = Repository.new(*@types)
    results = repository.search build_query
    BaseArticleSearchResponse.new self, results
  end

  def build_query
    BaseArticleSearchQuery.new countries: @countries,
                               industries: @industries,
                               limit: @limit,
                               offset: @offset,
                               q: @q,
                               topics: @topics,
                               trade_regions: @trade_regions,
                               world_regions: @world_regions
  end
end
