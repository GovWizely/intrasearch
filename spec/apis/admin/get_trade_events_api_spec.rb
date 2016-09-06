require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe Admin::GetTradeEventsAPI, endpoint: '/admin/trade_events' do
  include APISpecHelpers

  include_context 'API response'

  context 'when trade events are present' do
    include_context 'elastic models',
                    TradeEvent::DlTradeEvent,
                    TradeEvent::TradeEventExtra,
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
          id: '730226ea901d6c4bf7e4e4f5ef12ebec8c482a2b',
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
          end_time: '10:30',
          html_description: '<h1>SBA Trade Event 73022 description.</h1>',
          event_type: 'Resource Partner',
          hosted_url: 'https://example.org/trade_event?id=730226ea901d6c4bf7e4e4f5ef12ebec8c482a2b',
          industries: [
            'eCommerce Industry'
          ],
          md_description: '# SBA Trade Event 73022 description.',
          name: 'SBA Trade Event 73022',
          original_description: 'SBA Trade Event 73022 description.',
          registration_url: 'https://sba.trade.event.example.org/registration/73022',
          source: 'SBA',
          start_date: '2016-05-17',
          start_time: '08:30',
          time_zone: 'America/New_York',
          venues: [
            {
              'address': '600 Trade Drive',
              'city': 'Trade Township',
              'country': 'United States',
              'name': 'Trade Business Councils',
              'state': 'PA'
            },
            {
              'address': '100 Broadway',
              'city': 'New York',
              'country': 'United States',
              'name': 'Hotel TW',
              'state': 'NY'
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
                    TradeEvent::TradeEventExtra,
                    TradeEvent::ItaTradeEvent,
                    TradeEvent::SbaTradeEvent,
                    TradeEvent::UstdaTradeEvent,
                    skip_load_yaml: true

    before { get described_endpoint, 'limit' => 1, 'offset' => 2 }

    it_behaves_like 'a successful API response'
  end
end
