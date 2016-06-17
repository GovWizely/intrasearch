module TradeEvent
  module ItaUstdaTradeEventAttributes
    def self.included(base)
      base.attribute :cost, String, mapping: { index: 'not_analyzed' }
      base.attribute :countries, String, mapping: { index: 'not_analyzed' }
      base.attribute :description, String, mapping: { analyzer: 'english_analyzer' }
      base.attribute :end_date,
                Date,
                mapping: {
                  format: 'strict_date',
                  index: 'not_analyzed'
                }
      base.attribute :event_url, String, mapping: { index: 'not_analyzed' }
      base.attribute :industries, String, mapping: { index: 'not_analyzed' }
      base.attribute :industry_paths, String, mapping: { analyzer: 'path_analyzer' }
      base.attribute :name, String, mapping: { analyzer: 'english_analyzer' }
      base.attribute :registration_title, String, mapping: { analyzer: 'english_analyzer' }
      base.attribute :registration_url, String, mapping: { index: 'not_analyzed' }
      base.attribute :source, String, mapping: { index: 'not_analyzed' }
      base.attribute :trade_regions, String, mapping: { index: 'not_analyzed' }
      base.attribute :url, String, mapping: { index: 'not_analyzed' }
      base.attribute :venues, String, mapping: { analyzer: 'english_analyzer' }
      base.attribute :world_region_paths, String, mapping: { analyzer: 'path_analyzer' }
      base.attribute :world_regions, String, mapping: { index: 'not_analyzed' }
    end
  end
end
