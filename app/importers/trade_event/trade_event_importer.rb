require 'importer'
require 'importer_descendants_tracker'
require 'trade_event_transformer'

module TradeEvent
  module TradeEventImporter
    extend ImporterDescendantsTracker

    def self.extended(base)
      self.track_descendant base
      base.extend Importer

      class << base
        attr_accessor :extractor,
                      :model_class
      end

      base.model_class = base.name.sub(/Importer$/, '').constantize
      base.extractor = "#{base.model_class.name}Extractor".constantize
      base.extend ModuleMethods
    end

    module ModuleMethods
      def import
        super do
          trade_events = extractor.extract
          trade_events.each do |trade_event|
            TradeEventTransformer.transform trade_event
            model_class.create trade_event
          end
        end
      end
    end
  end
end
