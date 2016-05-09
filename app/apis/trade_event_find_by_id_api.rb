require 'trade_event_finder'
require 'trade_event_show_json_serializer'

class TradeEventFindByIdAPI < Grape::API
  version 'v1'

  params do
    requires :id, allow_blank: false
  end

  get '/trade_events/:id' do
    trade_event = TradeEventFinder.find(params.id).first
    trade_event ? TradeEventShowJSONSerializer.serialize(trade_event) : status(:not_found)
  end
end
