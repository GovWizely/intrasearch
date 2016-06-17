require 'search'
require 'trade_event/dl_trade_event'
require 'trade_event/ita_trade_event'
require 'trade_event/sba_trade_event'
require 'trade_event/ustda_trade_event'
require 'trade_event_finder'
require 'trade_event_list'
require 'trade_event_search'

module TradeEvent
  @models = [
    TradeEvent::DlTradeEvent,
    TradeEvent::ItaTradeEvent,
    TradeEvent::SbaTradeEvent,
    TradeEvent::UstdaTradeEvent
  ].freeze

  class << self
    attr_reader :models
  end

  def self.all(options = {})
    TradeEventList.new(options).run
  end

  def self.search(options)
    TradeEventSearch.new(options).run
  end

  def self.find_by_id(id)
    TradeEventFinder.find(id).first
  end
end
