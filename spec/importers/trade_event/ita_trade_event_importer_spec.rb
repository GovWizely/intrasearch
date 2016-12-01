require 'support/webservices_importer_shared_contexts'

RSpec.describe TradeEvent::ItaTradeEventImporter do
  describe '.import' do
    include_context 'webservices importer', Webservices::TradeEvent

    it 'imports trade events' do
      expected_attributes = {
        click_url: 'https://goo.gl/ita1',
        contacts: [
          {
            'email' => 'John.Doe@example.gov',
            'first_name' => 'John',
            'last_name' => 'Doe',
            'person_title' => 'Commercial Officer',
            'phone' => '886-2-1111-2222',
            'post' => 'Taipei'
          },
          {
            'email' => 'Jane.Doe@example.gov',
            'first_name' => 'Jane',
            'last_name' => 'Doe',
            'person_title' => 'Trade Specialist',
            'phone' => '82-2-333-4444',
            'post' => 'Seoul'
          }
        ],
        cost: 4400.0,
        countries: ['United States'],
        end_date: Date.parse('2016-05-24'),
        event_type: 'Trade Mission',
        expanded_industries: [
        'Franchising',
        'Information and Communication Technology',
        'Retail Trade',
        'eCommerce Industry'
      ],
        hosted_url: 'https://example.org/trade_event?id=ITA-36282',
        id: 'ITA-36282',
        industry_paths: [
          '/Franchising',
          '/Information and Communication Technology/eCommerce Industry',
          '/Retail Trade/eCommerce Industry'
        ],
        industries: [
          'Franchising',
          'eCommerce Industry'
        ],
        name: 'Trade Event 36282',
        original_description: 'Event 36282 description',
        registration_title: 'Event 36282 title',
        registration_url: 'https://ita.trade.event.example.org/registration/36282',
        source: 'ITA',
        start_date: Date.parse('2016-05-15'),
        trade_regions: ['Asia Pacific Economic Cooperation'],
        url: 'https://ita.trade.event.example.org/event/36282',
        venues: [
          {
            'city' => 'San Francisco',
            'country' => 'United States',
            'name' => 'Moscone Center, San Francisco',
            'postal_code' => nil,
            'state' => 'CA',
            'street' => nil,
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
