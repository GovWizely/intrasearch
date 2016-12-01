require 'support/webservices_importer_shared_contexts'

RSpec.describe TradeEvent::SbaTradeEventImporter do
  describe '.import' do
    include_context 'webservices importer', Webservices::TradeEvent

    it 'imports trade events' do
      expected_attributes = {
        contacts: [
          {
            'email' => 'john.doe@example.org',
            'first_name' => nil,
            'last_name' => 'Doe',
            'person_title' => nil,
            'phone' => '111-222-3333',
            'post' => 'Small Business Administration'
          }
        ],
        cost: 35.0,
        countries: ['United States'],
        original_description: 'SBA Trade Event 73022 description',
        end_date: Date.parse('2016-05-24'),
        end_time: '10:30 AM',
        event_type: 'Resource Partner',
        expanded_industries: [
          'Franchising',
          'Information and Communication Technology',
          'Retail Trade',
          'eCommerce Industry'
        ],
        hosted_url: 'https://example.org/trade_event?id=SBA-730226ea901d6c4bf7e4e4f5ef12ebec8c482a2b',
        id: 'SBA-730226ea901d6c4bf7e4e4f5ef12ebec8c482a2b',
        industry_paths: [
          '/Franchising',
          '/Information and Communication Technology/eCommerce Industry',
          '/Retail Trade/eCommerce Industry'
        ],
        industries: [
          'Franchising',
          'eCommerce Industry'
        ],
        name: 'SBA Trade Event 73022',
        registration_url: 'https://sba.trade.event.example.org/registration/73022',
        source: 'SBA',
        start_date: Date.parse('2016-05-17'),
        start_time: '8:30 AM',
        time_zone: 'America/New_York',
        trade_regions: ['Asia Pacific Economic Cooperation'],
        venues: [
          {
            'city' => 'Trade Township',
            'country' => 'United States',
            'name' => 'Trade Business Councils',
            'postal_code' => '19147',
            'state' => 'PA',
            'street' => '600 Trade Drive',
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
