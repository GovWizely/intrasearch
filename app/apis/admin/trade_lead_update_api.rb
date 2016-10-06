require 'admin/update_extra_attributes_api'
require 'trade_lead'

module Admin
  class TradeLeadUpdateAPI < Grape::API
    extend UpdateExtraAttributesAPI
  end
end
