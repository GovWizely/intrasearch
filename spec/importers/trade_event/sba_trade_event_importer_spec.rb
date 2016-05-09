require 'support/trade_event_importer_shared_contexts'

RSpec.describe TradeEvent::SbaTradeEventImporter do
  describe '.import' do
    include_context 'trade event importer'

    it 'imports trade events' do
      expected_attributes = {
        cost: '35.00',
        countries: ['United States'],
        description: 'SBA Trade Event 73022 description',
        end_date: Date.parse('2016-05-24'),
        id: '730226ea901d6c4bf7e4e4f5ef12ebec8c482a2b',
        industry_paths: [
          '/Franchising',
          '/Information and Communication Technology/eCommerce Industry',
          '/Retail Trade/eCommerce Industry'
        ],
        industries: [
          'Franchising',
          'Information and Communication Technology',
          'Retail Trade',
          'eCommerce Industry'
        ],
        name: 'SBA Trade Event 73022',
        registration_url: 'https://sba.trade.event.example.org/registration/73022',
        source: 'SBA',
        start_date: Date.parse('2016-05-17'),
        trade_regions: ['Asia Pacific Economic Cooperation'],
        url: 'https://example.org/trade_event?id=730226ea901d6c4bf7e4e4f5ef12ebec8c482a2b',
        venues: ['Trade Business Councils'],
        world_region_paths: [
          '/North America',
          '/Pacific Rim',
          '/Western Hemisphere'],
        world_regions: [
          'North America',
          'Pacific Rim',
          'Western Hemisphere',
        ]
      }

      described_class.import
      expect(model_class.count).to eq(1)
      expect(model_class.all.first).to have_attributes(expected_attributes)
    end
  end
end
