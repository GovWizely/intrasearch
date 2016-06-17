require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe Admin::TradeEventsAPI do
  include Rack::Test::Methods
  include APISpecHelpers

  include_context 'elastic models',
                  Country,
                  TradeEvent::DlTradeEvent,
                  TradeEvent::ItaTradeEvent,
                  TradeEvent::SbaTradeEvent,
                  TradeEvent::UstdaTradeEvent,
                  WorldRegion

  subject { last_response }
  let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

  describe 'list trade events', endpoint: '/admin/trade_events' do
    before { get described_endpoint, 'limit' => 1, 'offset' => 2 }

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

  describe 'find a trade event by id', endpoint: '/admin/trade_events/94c68284a1b7698becdcdaa69dda29bb2d76051c' do
    before { get described_endpoint }

    it_behaves_like 'a successful API response'

    it 'returns DL trade event attributes' do
      expected_attributes = {
        id: '94c68284a1b7698becdcdaa69dda29bb2d76051c',
        name: 'DL Trade Event 1',
        url: 'https://example.org/trade_event?id=94c68284a1b7698becdcdaa69dda29bb2d76051c',
        source: 'DL',
        event_url: 'http://dl.trade.event.example.org/1',
        description: 'Direct Line:A Political and Economic Update Bureau of Economic and Business Affairs. Register to receive information on future Direct Line calls. Brief Description of call: The U.S. Embassy presents an opportunity for U.S. businesses of all sizes to learn about the latest political and economic developments. Following the presentation, participants will have the opportunity to ask questions. Please RSVP by clicking here.',
        cost: nil,
        registration_title: nil,
        registration_url: nil,
        start_date: nil,
        end_date: nil,
        countries: [],
        industries: [],
        trade_regions: [],
        world_regions: []
      }
      expect(parsed_body).to eq(expected_attributes)
    end
  end
end
