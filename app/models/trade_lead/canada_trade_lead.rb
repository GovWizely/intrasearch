require 'trade_lead/base_model'

module TradeLead
  class CanadaTradeLead
    include BaseModel

    datetime_attributes :amended_at,
                        :end_at

    not_analyzed_attributes :amendment_number,
                            :bid_type,
                            :click_urls,
                            :competitive_procurement_strategy,
                            :contact,
                            :contract_number,
                            :countries,
                            :expanded_industries,
                            :implementing_entity,
                            :industries,
                            :notice_type,
                            :procurement_organization,
                            :publishing_status,
                            :reference_number,
                            :specific_location,
                            :trade_agreement,
                            :urls

    attribute :industry_paths, String, mapping: { analyzer: 'path_analyzer' }
  end
end
