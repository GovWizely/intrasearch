require 'support/trade_event_importer_shared_contexts'

RSpec.describe TradeEvent::ItaTradeEventImporter do
  describe '.import' do
    include_context 'trade event importer'

    it 'imports trade events' do
      expected_attributes = {
        cost: '4400.0',
        countries: ['United States'],
        description: 'Event 36282 description',
        end_date: Date.parse('2016-05-24'),
        event_url: 'https://ita.trade.event.example.org/event/36282',
        id: '36282',
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
        name: 'Trade Event 36282',
        registration_title: 'Event 36282 title',
        registration_url: 'https://ita.trade.event.example.org/registration/36282',
        source: 'ITA',
        start_date: Date.parse('2016-05-15'),
        trade_regions: ['Asia Pacific Economic Cooperation'],
        url: 'https://example.org/trade_event?id=36282',
        venues: ['Moscone Center, San Francisco'],
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
