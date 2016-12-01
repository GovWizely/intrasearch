require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe Admin::TradeEventListAPI, endpoint: '/admin/trade_events' do
  include APISpecHelpers

  include_context 'API response'

  context 'when trade events are present' do
    include_context 'elastic models',
                    TradeEvent::DlTradeEvent,
                    TradeEvent::Extra,
                    TradeEvent::ItaTradeEvent,
                    TradeEvent::SbaTradeEvent,
                    TradeEvent::UstdaTradeEvent

    before { get described_endpoint, 'limit' => 1, 'offset' => 2 }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 4,
                                           count: 1,
                                           offset: 2,
                                           next_offset: 3)
    end

    it 'returns trade events' do
      actual_results = parsed_body[:results]
      expected_results = [
        {
          id: 'SBA-730226ea901d6c4bf7e4e4f5ef12ebec8c482a2b',
          contacts: [
            {
              'email': 'john.doe@example.org',
              'last_name': 'Doe',
              'phone': '111-222-3333',
              'post': 'Small Business Administration'
            }
          ],
          cost: 35.0,
          end_date: '2016-05-24',
          end_time: '10:30 AM',
          html_description: '<h1>SBA Trade Event 73022 description.</h1>',
          event_type: 'Resource Partner',
          hosted_url: 'https://example.org/trade_event?id=SBA-730226ea901d6c4bf7e4e4f5ef12ebec8c482a2b',
          industries: [
            'eCommerce Industry'
          ],
          md_description: '# SBA Trade Event 73022 description.',
          name: 'SBA Trade Event 73022',
          original_description: 'SBA Trade Event 73022 description.',
          registration_click_url: 'https://goo.gl/sba1',
          registration_url: 'https://sba.trade.event.example.org/registration/73022',
          source: 'SBA',
          start_date: '2016-05-17',
          start_time: '8:30 AM',
          time_zone: 'America/New_York',
          venues: [
            {
              'city': 'Trade Township',
              'country': 'United States',
              'name': 'Trade Business Councils',
              'postal_code': '19147',
              'state': 'PA',
              'street': '600 Trade Drive'
            },
            {
              'city': 'New York',
              'country': 'United States',
              'name': 'Hotel TW',
              'postal_code': '10001',
              'state': 'NY',
              'street': '100 Broadway'
            }
          ]
        }
      ]

      expect(actual_results).to eq(expected_results)
    end
  end

  context 'when there are no trade events' do
    include_context 'elastic models',
                    TradeEvent::DlTradeEvent,
                    TradeEvent::Extra,
                    TradeEvent::ItaTradeEvent,
                    TradeEvent::SbaTradeEvent,
                    TradeEvent::UstdaTradeEvent,
                    skip_load_yaml: true

    before { get described_endpoint, 'limit' => 1, 'offset' => 2 }

    it_behaves_like 'a successful API response'
  end
end
