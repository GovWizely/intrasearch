require 'trade_event_search_query'
require 'trade_event_search_response'
require 'repository'
require 'search'

class TradeEventSearch
  include Search

  def initialize(options)
    super
    @countries = options[:countries].to_s.split(',')
    @industries = options[:industries].to_s.split(',')
    @trade_regions = options[:trade_regions].to_s.split(',')
    @world_regions = options[:world_regions].to_s.split(',')
  end

  def run
    repository = TradeEventRepository.new
    results = repository.search build_query
    TradeEventSearchResponse.new self, results
  end

  def build_query
    TradeEventSearchQuery.new countries: @countries,
                              industries: @industries,
                              limit: @limit,
                              offset: @offset,
                              q: @q,
                              trade_regions: @trade_regions,
                              world_regions: @world_regions
  end
end
