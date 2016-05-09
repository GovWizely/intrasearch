require 'support/trade_event_importer_shared_contexts'

RSpec.describe TradeEvent::DlTradeEventImporter do
  describe '.import' do
    include_context 'trade event importer'

    it 'imports DL trade events' do
      expected_attributes = {
        description: 'Trade Event 1 Description',
        event_url: 'http://dl.trade.event.example.org/1',
        id: '22346b67a36ab6acb9980bfefde51d2db041b5ed',
        name: 'Trade Event 1',
        source: 'DL',
        url: 'https://example.org/trade_event?id=22346b67a36ab6acb9980bfefde51d2db041b5ed'
      }

      described_class.import
      expect(model_class.count).to eq(1)
      expect(model_class.all.first).to have_attributes(expected_attributes)
    end
  end
end
