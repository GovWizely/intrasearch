require 'trade_event/dl_trade_event'
require 'trade_event/ita_trade_event'
require 'trade_event/sba_trade_event'
require 'trade_event/ustda_trade_event'
require 'trade_event_search_query'
require 'trade_event_search_response'
require 'repository'
require 'search'

class TradeEventSearch
  include Search

  TYPES = [
    TradeEvent::DlTradeEvent,
    TradeEvent::ItaTradeEvent,
    TradeEvent::SbaTradeEvent,
    TradeEvent::UstdaTradeEvent
  ].freeze

  def initialize(options)
    super
    @countries = options[:countries].to_s.split(',')
    @industries = options[:industries].to_s.split(',')
    @trade_regions = options[:trade_regions].to_s.split(',')
    @world_regions = options[:world_regions].to_s.split(',')
  end

  def run
    repository = TradeEventRepository.new(*TYPES)
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
