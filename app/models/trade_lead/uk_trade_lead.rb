require 'trade_lead/base_model'

module TradeLead
  class UkTradeLead
    include BaseModel

    datetime_attributes :contract_end_at,
                        :contract_start_at,
                        :deadline_at

    not_analyzed_attributes String,
                            :click_url,
                            :contact,
                            :expanded_industries,
                            :industries,
                            :notice_type,
                            :procurement_organization,
                            :record_id,
                            :reference_number,
                            :specific_location,
                            :status,
                            :url

    not_analyzed_attributes Float,
                            :max_contract_value,
                            :min_contract_value

    attribute :industry_paths, String, mapping: { analyzer: 'path_analyzer' }
  end
end
