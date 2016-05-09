require 'trade_event_search'

class TradeEventCountAPI < Grape::API
  version 'v1'

  get '/trade_events/count' do
    TradeEventSearch.new(search_type: :count).run
  end
end
