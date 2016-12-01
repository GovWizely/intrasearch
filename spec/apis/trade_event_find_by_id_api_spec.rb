require 'support/api_shared_examples'
require 'support/elastic_model_shared_contexts'

RSpec.describe TradeEventFindByIdAPI do
  include Rack::Test::Methods

  def app
    Intrasearch::Application
  end

  include_context 'elastic models',
                  TradeEvent::DlTradeEvent,
                  TradeEvent::Extra,
                  TradeEvent::ItaTradeEvent,
                  TradeEvent::SbaTradeEvent,
                  TradeEvent::UstdaTradeEvent

  describe 'finding DL trade event' do
    before { get '/v2/trade_events/DL-94c68284a1b7698becdcdaa69dda29bb2d76051c' }

    subject { last_response }
    let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

    it_behaves_like 'a successful API response'

    it 'returns DL trade event attributes' do
      expected_attributes = {
        id: 'DL-94c68284a1b7698becdcdaa69dda29bb2d76051c',
        click_url: 'https://goo.gl/dl1',
        description: 'Direct Line:A Political and Economic Update Bureau of Economic and Business Affairs. Register to receive information on future Direct Line calls. Brief Description of call: The U.S. Embassy presents an opportunity for U.S. businesses of all sizes to learn about the latest political and economic developments. Following the presentation, participants will have the opportunity to ask questions. Please RSVP by clicking here.',
        hosted_url: 'https://example.org/trade_event?id=DL-94c68284a1b7698becdcdaa69dda29bb2d76051c',
        name: 'DL Trade Event 1',
        source: 'DL',
        url: 'http://dl.trade.event.example.org/1'
      }
      expect(parsed_body).to eq(expected_attributes)
    end
  end

  describe 'finding ITA trade event' do
    before { get '/v2/trade_events/ITA-36282' }

    subject { last_response }
    let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

    it_behaves_like 'a successful API response'

    it 'returns ITA trade event attributes' do
      expected_attributes = {
        id: 'ITA-36282',
        click_url: 'https://goo.gl/ita1',
        contacts: [
          {
            email: 'John.Doe@example.gov',
            first_name: 'John',
            last_name: 'Doe',
            person_title: 'Commercial Officer',
            phone: '886-2-1111-2222',
            post: 'Taipei'
          },
          {
            email: 'Jane.Doe@example.gov',
            first_name: 'Jane',
            last_name: 'Doe',
            person_title: 'Trade Specialist',
            phone: '82-2-333-4444',
            post: 'Seoul'
          }
        ],
        cost: 4400.0,
        description: '<h1>Event 36282 description.</h1>',
        end_date: '2016-05-24',
        event_type: 'Trade Mission',
        hosted_url: 'https://example.org/trade_event?id=ITA-36282',
        industries: ['Franchising'],
        name: 'Trade Event 36282',
        registration_title: 'Event 36282 title',
        registration_url: 'https://ita.trade.event.example.org/registration/36282',
        source: 'ITA',
        start_date: '2016-05-15',
        url: 'https://ita.trade.event.example.org/event/36282',
        venues: [
          city: 'San Francisco',
          country: 'United States',
          name: 'Moscone Center, San Francisco',
          postal_code: nil,
          state: 'CA',
          street: nil
        ]
      }
      expect(parsed_body).to eq(expected_attributes)
    end
  end

  describe 'finding SBA trade event' do
    before { get '/v2/trade_events/SBA-730226ea901d6c4bf7e4e4f5ef12ebec8c482a2b' }

    subject { last_response }
    let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

    it_behaves_like 'a successful API response'

    it 'returns SBA trade event attributes' do
      expected_attributes = {
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
        description: '<h1>SBA Trade Event 73022 description.</h1>',
        end_date: '2016-05-24',
        end_time: '10:30 AM',
        name: 'SBA Trade Event 73022',
        event_type: 'Resource Partner',
        hosted_url: 'https://example.org/trade_event?id=SBA-730226ea901d6c4bf7e4e4f5ef12ebec8c482a2b',
        industries: [
          'eCommerce Industry'
        ],
        registration_url: 'https://sba.trade.event.example.org/registration/73022',
        registration_click_url: 'https://goo.gl/sba1',
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
            'street': '100 Broadway',
          }
        ]
      }
      expect(parsed_body).to eq(expected_attributes)
    end
  end

  describe 'finding USTDA trade event' do
    before { get '/v2/trade_events/USTDA-f0e2598dbc76ce55cd0a557746375bd911808bac' }

    subject { last_response }
    let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

    it_behaves_like 'a successful API response'

    it 'returns USTDA trade event attributes' do
      expected_attributes = {
        id: 'USTDA-f0e2598dbc76ce55cd0a557746375bd911808bac',
        contacts: [
          {
            email: 'john.doe@example.org',
            first_name: 'John',
            last_name: 'Doe',
            person_title: '$person_title',
            phone: '111-222-3333',
            post: '$post'
          }
        ],
        click_url: 'https://goo.gl/ustda1',
        cost: 25.0,
        cost_currency: 'USD',
        description: 'USTDA Trade Event f0e259 description.',
        end_date: '2016-05-24',
        end_time: '5:46 PM',
        hosted_url: 'https://example.org/trade_event?id=USTDA-f0e2598dbc76ce55cd0a557746375bd911808bac',
        industries: [
          'eCommerce Industry'
        ],
        name: 'USTDA Trade Event Summit f0e259',
        registration_title: 'USTDA Awesome Trade Event Summit',
        registration_url: 'http://ustda.trade.events.example.org/registration/f0e259',
        source: 'USTDA',
        start_date: '2016-05-17',
        start_time: '3:46 PM',
        url: 'http://ustda.trade.events.example.org/event/f0e259',
        venues: [
          {
            city: 'Washington',
            country: 'United States',
            name: 'Washington, D.C.',
            postal_code: nil,
            state: nil,
            street: nil
          }
        ]
      }
      expect(parsed_body).to eq(expected_attributes)
    end
  end
end
