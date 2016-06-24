require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe Admin::GetTradeEventAPI do
  include Rack::Test::Methods
  include APISpecHelpers

  include_context 'elastic models',
                  Country,
                  TradeEvent::DlTradeEvent,
                  TradeEvent::TradeEventExtra,
                  TradeEvent::ItaTradeEvent,
                  TradeEvent::SbaTradeEvent,
                  TradeEvent::UstdaTradeEvent,
                  WorldRegion

  include_context 'API response'

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
        md_description: nil,
        html_description: nil,
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

  describe 'find a trade event by id', endpoint: '/admin/trade_events/36282' do
    before { get described_endpoint }

    it_behaves_like 'a successful API response'

    it 'returns ITA trade event attributes' do
      expected_attributes = {
        id: '36282',
        name: 'Trade Event 36282',
        url: 'https://example.org/trade_event?id=36282',
        source: 'ITA',
        event_url: 'https://ita.trade.event.example.org/event/36282',
        description: 'Event 36282 description.',
        md_description: '# Event 36282 description',
        html_description: '<h1>Event 36282 description.</h1>',
        cost: '4400.0',
        registration_title: 'Event 36282 title',
        registration_url: 'https://ita.trade.event.example.org/registration/36282',
        start_date: '2016-05-15',
        end_date: '2016-05-24',
        countries: ['United States'],
        industries: ['Franchising'],
        trade_regions: [
          'Asia Pacific Economic Cooperation',
          'NAFTA'
        ],
        world_regions: [
          'North America',
          'Pacific Rim',
          'Western Hemisphere'
        ]
      }
      expect(parsed_body).to eq(expected_attributes)
    end
  end
end
