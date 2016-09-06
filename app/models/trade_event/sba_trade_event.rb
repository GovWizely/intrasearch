require 'trade_event/base_model'

module TradeEvent
  class SbaTradeEvent
    include BaseModel

    contacts_attribute
    venues_attribute

    analyzed_attributes 'path_analyzer',
                        :industry_paths,
                        :world_region_paths

    custom_attributes 'double', :cost

    date_attributes :end_date

    not_analyzed_attributes :countries,
                            :end_time,
                            :event_type,
                            :expanded_industries,
                            :industries,
                            :registration_url,
                            :start_time,
                            :time_zone,
                            :trade_regions,
                            :world_regions
  end
end
