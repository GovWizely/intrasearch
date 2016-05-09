require 'trade_event/base_trade_event_model'

module TradeEvent
  class DlTradeEvent
    include BaseTradeEventModel

    attribute :description, String, mapping: { analyzer: 'english_analyzer' }
    attribute :name, String, mapping: { analyzer: 'english_analyzer' }
    attribute :event_url, String, mapping: { index: 'not_analyzed' }
    attribute :source, String, mapping: { index: 'not_analyzed' }
    attribute :url, String, mapping: { index: 'not_analyzed' }
  end
end
