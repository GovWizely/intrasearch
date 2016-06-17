require 'trade_event_match_all_query'
require 'trade_event_search_response'
require 'repository'
require 'search'

class TradeEventList
  DEFAULT_OFFSET = 0
  DEFAULT_LIMIT = 30

  attr_reader :limit, :offset

  def initialize(options)
    @limit = options[:limit] || DEFAULT_LIMIT
    @offset = options[:offset] || DEFAULT_OFFSET
  end

  def run
    repository = TradeEventRepository.new
    results = repository.search build_query
    TradeEventListResponse.new self, results
  end

  def build_query
    TradeEventMatchAllQuery.new limit: @limit,
                                offset: @offset
  end
end
