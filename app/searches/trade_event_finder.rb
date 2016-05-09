require 'find_by_id_query'
require 'trade_event_repository'
require 'trade_event/dl_trade_event'
require 'trade_event/ita_trade_event'
require 'trade_event/sba_trade_event'
require 'trade_event/ustda_trade_event'

module TradeEventFinder
  TYPES = [
    TradeEvent::DlTradeEvent,
    TradeEvent::ItaTradeEvent,
    TradeEvent::SbaTradeEvent,
    TradeEvent::UstdaTradeEvent
  ].freeze

  def self.find(id)
    repository = TradeEventRepository.new(*TYPES)
    query = FindByIdQuery.new id
    repository.search query
  end
end
