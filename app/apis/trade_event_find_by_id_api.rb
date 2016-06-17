require 'trade_event'
require 'trade_event_show_json_serializer'

module TradeEventFindByIdAPI
  def self.extended(base)
    base.class_eval do
      params do
        requires :id, allow_blank: false
      end

      get '/trade_events/:id' do
        trade_event = TradeEvent.find_by_id params.id
        trade_event ? TradeEventShowJSONSerializer.serialize(trade_event) : status(:not_found)
      end
    end
  end
end
