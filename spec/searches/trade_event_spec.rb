require 'support/elastic_model_shared_contexts'

RSpec.describe TradeEvent do
  include_context 'elastic models',
                  Country,
                  TradeEvent::DlTradeEvent,
                  TradeEvent::Extra,
                  TradeEvent::ItaTradeEvent,
                  TradeEvent::SbaTradeEvent,
                  TradeEvent::UstdaTradeEvent,
                  TradeRegion,
                  WorldRegion

  describe '.ids' do
    it 'returns ids from all TradeEvent models' do
      expected_ids = %w(
        ITA-36282
        SBA-730226ea901d6c4bf7e4e4f5ef12ebec8c482a2b
        DL-94c68284a1b7698becdcdaa69dda29bb2d76051c
        USTDA-f0e2598dbc76ce55cd0a557746375bd911808bac
      )
      expect(described_class.ids).to match_array(expected_ids)
    end
  end
end