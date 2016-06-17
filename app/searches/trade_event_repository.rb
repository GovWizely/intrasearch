require 'repository'
require 'trade_event'

class TradeEventRepository < Repository
  def initialize
    super(*TradeEvent.models)
  end

  private

  def get_klass_from_type(type)
    klass = "trade_event/#{type}".classify
    klass.constantize
  end
end
