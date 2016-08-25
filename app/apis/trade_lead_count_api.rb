require 'trade_lead'

class TradeLeadCountAPI < Grape::API
  get '/trade_leads/count' do
    TradeLead.search(search_type: :count)
  end
end
