require 'trade_lead/base_model'

module TradeLead
  class FboTradeLead
    include BaseModel

    datetime_attributes :end_at

    not_analyzed_attributes :classification_code,
                            :click_url,
                            :competitive_procurement_strategy,
                            :contact,
                            :contract_number,
                            :expanded_industries,
                            :industries,
                            :notice_type,
                            :procurement_office,
                            :procurement_office_address,
                            :procurement_organization,
                            :procurement_organization_address,
                            :specific_address,
                            :url

    attribute :industry_paths, String, mapping: { analyzer: 'path_analyzer' }
  end
end
