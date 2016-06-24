require 'trade_event'

module Admin
  class GetTradeEventsAPI < Grape::API
    params do
      optional :limit,
               type: Integer,
               values: 1..30
      optional :offset,
               type: Integer,
               regexp: /\A\d+\Z/
    end

    get '/trade_events' do
      TradeEvent.all declared(params, include_missing: false)
    end
  end
end
