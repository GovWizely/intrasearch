require 'trade_lead/base_model'

module TradeLead
  class StateTradeLead
    include BaseModel

    datetime_attributes :end_at

    not_analyzed_attributes :borrowing_entity,
                            :click_url,
                            :comments,
                            :contact,
                            :expanded_industries,
                            :funding_source,
                            :industries,
                            :lead_source,
                            :procurement_organization,
                            :project_number,
                            :record_id,
                            :specific_location,
                            :status,
                            :submitting_officer,
                            :submitting_officer_contact,
                            :tags,
                            :url

    attribute :industry_paths, String, mapping: { analyzer: 'path_analyzer' }
    attribute :project_size, nil, mapping: { type: 'long' }
  end
end
