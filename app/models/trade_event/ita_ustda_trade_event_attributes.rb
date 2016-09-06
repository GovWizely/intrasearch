module TradeEvent
  module ItaUstdaTradeEventAttributes
    def self.included(base)
      base.module_eval do
        analyzed_attributes 'path_analyzer',
                            :industry_paths,
                            :world_region_paths

        custom_attributes 'double', :cost

        date_attributes :end_date

        contacts_attribute
        venues_attribute

        not_analyzed_attributes :countries,
                                :expanded_industries,
                                :industries,
                                :registration_title,
                                :registration_url,
                                :trade_regions,
                                :url,
                                :world_regions
      end
    end
  end
end
