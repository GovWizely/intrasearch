require 'support/webservices_importer_shared_contexts'

RSpec.describe TradeEvent::DlTradeEventImporter do
  describe '.import' do
    include_context 'webservices importer', Webservices::TradeEvent

    it 'imports DL trade events' do
      expected_attributes = {
        click_url: 'https://goo.gl/dl1',
        hosted_url: 'https://example.org/trade_event?id=DL-22346b67a36ab6acb9980bfefde51d2db041b5ed',
        id: 'DL-22346b67a36ab6acb9980bfefde51d2db041b5ed',
        name: 'Trade Event 1',
        original_description: 'Trade Event 1 Description',
        source: 'DL',
        url: 'http://dl.trade.event.example.org/1'
      }

      described_class.import
      expect(model_class.count).to eq(1)
      expect(model_class.all.first).to have_attributes(expected_attributes)
    end
  end
end
