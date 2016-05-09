require 'repository'

class TradeEventRepository < Repository
  private

  def get_klass_from_type(type)
    klass = "trade_event/#{type}".classify
    klass.constantize
  end
end
