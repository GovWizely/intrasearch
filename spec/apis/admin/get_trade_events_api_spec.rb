require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe Admin::GetTradeEventsAPI, endpoint: '/admin/trade_events' do
  include Rack::Test::Methods
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
          name: 'SBA Trade Event 73022',
          url: 'https://example.org/trade_event?id=730226ea901d6c4bf7e4e4f5ef12ebec8c482a2b',
          source: 'SBA',
          event_url: nil,
          description: 'SBA Trade Event 73022 description.',
          md_description: '# SBA Trade Event 73022 description.',
          html_description: '<h1>SBA Trade Event 73022 description.</h1>',
          cost: '35.00',
          registration_title: nil,
          registration_url: 'https://sba.trade.event.example.org/registration/73022',
          start_date: '2016-05-17',
          end_date: '2016-05-24',
          countries: ['United States'],
          industries: [
            'Information and Communication Technology',
            'Retail Trade',
            'eCommerce Industry'
          ],
          trade_regions: ['Asia Pacific Economic Cooperation'],
          world_regions: [
            'North America',
            'Pacific Rim',
            'Western Hemisphere'
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
