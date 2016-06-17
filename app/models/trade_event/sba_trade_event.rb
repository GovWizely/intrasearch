require 'trade_event/base_trade_event_model'

module TradeEvent
  class SbaTradeEvent
    include BaseTradeEventModel

    attribute :cost, String, mapping: { index: 'not_analyzed' }
    attribute :countries, String, mapping: { index: 'not_analyzed' }
    attribute :description, String, mapping: { analyzer: 'english_analyzer' }
    attribute :end_date,
              Date,
              mapping: {
                format: 'strict_date',
                index: 'not_analyzed'
              }
    attribute :industries, String, mapping: { index: 'not_analyzed' }
    attribute :industry_paths, String, mapping: { analyzer: 'path_analyzer' }
    attribute :name, String, mapping: { analyzer: 'english_analyzer' }
    attribute :registration_url, String, mapping: { index: 'not_analyzed' }
    attribute :source, String, mapping: { index: 'not_analyzed' }
    attribute :trade_regions, String, mapping: { index: 'not_analyzed' }
    attribute :url, String, mapping: { index: 'not_analyzed' }
    attribute :venues, String, mapping: { analyzer: 'english_analyzer' }
    attribute :world_region_paths, String, mapping: { analyzer: 'path_analyzer' }
    attribute :world_regions, String, mapping: { index: 'not_analyzed' }
  end
end
