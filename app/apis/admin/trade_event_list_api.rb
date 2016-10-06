require 'admin/list_api'
require 'trade_event'

module Admin
  class TradeEventListAPI < Grape::API
    extend ListAPI
  end
end
