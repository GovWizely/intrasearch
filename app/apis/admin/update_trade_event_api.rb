require 'trade_event'

module Admin
  class UpdateTradeEventAPI < Grape::API
    params do
      requires :id, allow_blank: false
      requires :html_description, :md_description
    end

    patch '/trade_events/:id' do
      declared_params = declared params
      trade_event = TradeEvent.find_by_id(declared_params.id)

      if trade_event
        trade_event.update_extra_attributes(declared_params) ? {} : status(:internal_server_error)
      else
        status :not_found
      end
    end
  end
end
