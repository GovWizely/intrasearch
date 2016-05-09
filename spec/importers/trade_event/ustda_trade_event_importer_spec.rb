require 'support/trade_event_importer_shared_contexts'

RSpec.describe TradeEvent::UstdaTradeEventImporter do
  describe '.import' do
    include_context 'trade event importer'

    it 'imports trade events' do
      expected_attributes = {
        cost: nil,
        countries: ['United States'],
        description: 'USTDA Trade Event f0e259 description',
        end_date: Date.parse('2016-05-24'),
        event_url: 'http://ustda.trade.events.example.org/event/f0e259',
        id: 'f0e2598dbc76ce55cd0a557746375bd911808bac',
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
        name: 'USTDA Trade Event Summit f0e259',
        registration_title: 'USTDA Awesome Trade Event Summit',
        registration_url: 'http://ustda.trade.events.example.org/registration/f0e259',
        source: 'USTDA',
        start_date: Date.parse('2016-05-17'),
        trade_regions: ['Asia Pacific Economic Cooperation'],
        url: 'https://example.org/trade_event?id=f0e2598dbc76ce55cd0a557746375bd911808bac',
        venues: ['Washington, D.C.'],
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
