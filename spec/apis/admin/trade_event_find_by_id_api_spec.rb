require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe Admin::TradeEventFindByIdAPI do
  include APISpecHelpers

  include_context 'elastic models',
                  Country,
                  TradeEvent::DlTradeEvent,
                  TradeEvent::Extra,
                  TradeEvent::ItaTradeEvent,
                  TradeEvent::SbaTradeEvent,
                  TradeEvent::UstdaTradeEvent,
                  WorldRegion

  include_context 'API response'

  describe 'find a DL trade event by id', endpoint: '/admin/trade_events/DL-94c68284a1b7698becdcdaa69dda29bb2d76051c' do
    before { get described_endpoint }

    it_behaves_like 'a successful API response'

    it 'returns DL trade event attributes' do
      expected_attributes = {
        id: 'DL-94c68284a1b7698becdcdaa69dda29bb2d76051c',
        click_url: 'https://goo.gl/dl1',
        hosted_url: 'https://example.org/trade_event?id=DL-94c68284a1b7698becdcdaa69dda29bb2d76051c',
        html_description: nil,
        md_description: nil,
        name: 'DL Trade Event 1',
        original_description: 'Direct Line:A Political and Economic Update Bureau of Economic and Business Affairs. Register to receive information on future Direct Line calls. Brief Description of call: The U.S. Embassy presents an opportunity for U.S. businesses of all sizes to learn about the latest political and economic developments. Following the presentation, participants will have the opportunity to ask questions. Please RSVP by clicking here.',
        source: 'DL',
        url: 'http://dl.trade.event.example.org/1'
      }
      expect(parsed_body).to eq(expected_attributes)
    end
  end

  describe 'find an ITA trade event by id', endpoint: '/admin/trade_events/ITA-36282' do
    before { get described_endpoint }

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
        end_date: '2016-05-24',
        event_type: 'Trade Mission',
        hosted_url: 'https://example.org/trade_event?id=ITA-36282',
        html_description: '<h1>Event 36282 description.</h1>',
        industries: ['Franchising'],
        md_description: '# Event 36282 description.',
        name: 'Trade Event 36282',
        original_description: 'Event 36282 description.',
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

  describe 'find an SBA trade event by id', endpoint: '/admin/trade_events/SBA-730226ea901d6c4bf7e4e4f5ef12ebec8c482a2b' do
    before { get described_endpoint }

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
            'street': '100 Broadway',
          }
        ]
      }
      expect(parsed_body).to eq(expected_attributes)
    end
  end

  describe 'find an USTDA trade event by id', endpoint: '/admin/trade_events/USTDA-f0e2598dbc76ce55cd0a557746375bd911808bac' do
    before { get described_endpoint }

    it_behaves_like 'a successful API response'

    it 'returns USTDA trade event attributes' do
      expected_attributes = {
        id: 'USTDA-f0e2598dbc76ce55cd0a557746375bd911808bac',
        click_url: 'https://goo.gl/ustda1',
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
        cost: 25.0,
        cost_currency: 'USD',
        end_date: '2016-05-24',
        end_time: '5:46 PM',
        hosted_url: 'https://example.org/trade_event?id=USTDA-f0e2598dbc76ce55cd0a557746375bd911808bac',
        html_description: nil,
        industries: [
          'eCommerce Industry'
        ],
        md_description: nil,
        name: 'USTDA Trade Event Summit f0e259',
        original_description: 'USTDA Trade Event f0e259 description.',
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
