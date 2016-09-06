require 'trade_lead/base_model'

module TradeLead
  class AustraliaTradeLead
    include BaseModel

    datetime_attributes :end_at

    not_analyzed_attributes :agency,
                            :app_reference,
                            :atm_id,
                            :atm_type,
                            :click_url,
                            :conditions_for_participation,
                            :contact_officer,
                            :delivery_timeframe,
                            :email,
                            :expanded_industries,
                            :industries,
                            :location,
                            :lodgement_address,
                            :multi_agency_access,
                            :other_instructions,
                            :panel_arrangement,
                            :phone,
                            :url

    attribute :industry_paths, String, mapping: { analyzer: 'path_analyzer' }
  end
end
