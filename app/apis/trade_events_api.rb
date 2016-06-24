require 'get_trade_event_api'
require 'trade_event_count_api'
require 'trade_event_search_api'

class TradeEventsAPI < Grape::API
  version 'v1'

  mount TradeEventCountAPI
  mount TradeEventSearchAPI
  mount GetTradeEventAPI
end
