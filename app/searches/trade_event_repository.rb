require 'repository'
require 'trade_event'
require 'trade_event/dl_trade_event'
require 'trade_event/ita_trade_event'
require 'trade_event/sba_trade_event'
require 'trade_event/ustda_trade_event'

class TradeEventRepository < Repository
  def initialize
    super TradeEvent::DlTradeEvent,
          TradeEvent::ItaTradeEvent,
          TradeEvent::SbaTradeEvent,
          TradeEvent::UstdaTradeEvent
  end

  private

  def get_klass_from_type(type)
    klass = "trade_event/#{type}".classify
    klass.constantize
  end
end
