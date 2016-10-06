require 'admin/list_api'
require 'trade_lead'

module Admin
  class TradeLeadListAPI < Grape::API
    extend ListAPI
  end
end
