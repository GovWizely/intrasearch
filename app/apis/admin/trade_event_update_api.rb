require 'admin/update_extra_attributes_api'
require 'trade_event'

module Admin
  class TradeEventUpdateAPI < Grape::API
    extend UpdateExtraAttributesAPI
  end
end
