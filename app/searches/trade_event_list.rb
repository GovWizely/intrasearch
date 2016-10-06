require 'list_with_extra'
require 'trade_event/extra'
require 'trade_event_list_response'
require 'trade_event_match_all_query'
require 'trade_event_repository'

class TradeEventList
  include ListWithExtra

  self.extra_model_class = TradeEvent::Extra
  self.query_class = TradeEventMatchAllQuery
  self.repository_class = TradeEventRepository
  self.response_class = TradeEventListResponse
end
