require 'support/webservices_importer_shared_contexts'

RSpec.describe TradeEvent::UstdaTradeEventImporter do
  describe '.import' do
    include_context 'webservices importer', Webservices::TradeEvent

    it 'imports trade events' do
      expected_attributes = {
        contacts: [
          {
            'email' => 'john.doe@example.org',
            'first_name' => 'John',
            'last_name' => 'Doe',
            'person_title' => '$person_title',
            'phone' => '111-222-3333',
            'post' => '$post'
          }
        ],
        cost: 25.0,
        cost_currency: 'USD',
        countries: ['United States'],
        end_date: Date.parse('2016-05-24'),
        end_time: '5:46 PM',
        expanded_industries: [
          'Franchising',
          'Information and Communication Technology',
          'Retail Trade',
          'eCommerce Industry'
        ],
        hosted_url: 'https://example.org/trade_event?id=USTDA-f0e2598dbc76ce55cd0a557746375bd911808bac',
        id: 'USTDA-f0e2598dbc76ce55cd0a557746375bd911808bac',
        industry_paths: [
          '/Franchising',
          '/Information and Communication Technology/eCommerce Industry',
          '/Retail Trade/eCommerce Industry'
        ],
        industries: [
          'Franchising',
          'eCommerce Industry'
        ],
        name: 'USTDA Trade Event Summit f0e259',
        original_description: 'USTDA Trade Event f0e259 description',
        registration_title: 'USTDA Awesome Trade Event Summit',
        registration_url: 'http://ustda.trade.events.example.org/registration/f0e259',
        source: 'USTDA',
        start_date: Date.parse('2016-05-17'),
        start_time: '3:46 PM',
        trade_regions: ['Asia Pacific Economic Cooperation'],
        url: 'http://ustda.trade.events.example.org/event/f0e259',
        venues: [
          {
            'city' => 'Washington',
            'country' => 'United States',
            'name' => 'Washington, D.C.',
            'postal_code' => nil,
            'state' => nil,
            'street' => nil
          }
        ],
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
