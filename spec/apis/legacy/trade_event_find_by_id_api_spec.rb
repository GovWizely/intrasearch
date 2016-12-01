require 'support/api_shared_examples'
require 'support/elastic_model_shared_contexts'

RSpec.describe Legacy::TradeEventFindByIdAPI do
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
    before { get '/v1/trade_events/DL-94c68284a1b7698becdcdaa69dda29bb2d76051c' }

    subject { last_response }
    let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

    it_behaves_like 'a successful API response'

    it 'returns DL trade event attributes' do
      expected_attributes = {
        id: 'DL-94c68284a1b7698becdcdaa69dda29bb2d76051c',
        name: 'DL Trade Event 1',
        url: 'https://example.org/trade_event?id=DL-94c68284a1b7698becdcdaa69dda29bb2d76051c',
        source: 'DL',
        event_url: 'http://dl.trade.event.example.org/1',
        description: 'Direct Line:A Political and Economic Update Bureau of Economic and Business Affairs. Register to receive information on future Direct Line calls. Brief Description of call: The U.S. Embassy presents an opportunity for U.S. businesses of all sizes to learn about the latest political and economic developments. Following the presentation, participants will have the opportunity to ask questions. Please RSVP by clicking here.',
        cost: nil,
        registration_title: nil,
        registration_url: nil,
        start_date: nil,
        end_date: nil,
        countries: [],
        industries: []
      }
      expect(parsed_body).to eq(expected_attributes)
    end
  end

  describe 'finding ITA trade event' do
    before { get '/v1/trade_events/ITA-36282' }

    subject { last_response }
    let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

    it_behaves_like 'a successful API response'

    it 'returns ITA trade event attributes' do
      expected_attributes = {
        id: 'ITA-36282',
        name: 'Trade Event 36282',
        url: 'https://example.org/trade_event?id=ITA-36282',
        source: 'ITA',
        event_url: 'https://ita.trade.event.example.org/event/36282',
        description: '<h1>Event 36282 description.</h1>',
        cost: 4400.0,
        registration_title: 'Event 36282 title',
        registration_url: 'https://ita.trade.event.example.org/registration/36282',
        start_date: '2016-05-15',
        end_date: '2016-05-24',
        countries: ['United States'],
        industries: ['Franchising']
      }
      expect(parsed_body).to eq(expected_attributes)
    end
  end

  describe 'finding SBA trade event' do
    before { get '/v1/trade_events/SBA-730226ea901d6c4bf7e4e4f5ef12ebec8c482a2b' }

    subject { last_response }
    let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

    it_behaves_like 'a successful API response'

    it 'returns SBA trade event attributes' do
      expected_attributes = {
        id: 'SBA-730226ea901d6c4bf7e4e4f5ef12ebec8c482a2b',
        name: 'SBA Trade Event 73022',
        url: 'https://example.org/trade_event?id=SBA-730226ea901d6c4bf7e4e4f5ef12ebec8c482a2b',
        source: 'SBA',
        event_url: nil,
        description: '<h1>SBA Trade Event 73022 description.</h1>',
        cost: 35.0,
        registration_title: nil,
        registration_url: 'https://sba.trade.event.example.org/registration/73022',
        start_date: '2016-05-17',
        end_date: '2016-05-24',
        countries: ['United States'],
        industries: ['eCommerce Industry']
      }
      expect(parsed_body).to eq(expected_attributes)
    end
  end

  describe 'finding USTDA trade event' do
    before { get '/v1/trade_events/USTDA-f0e2598dbc76ce55cd0a557746375bd911808bac' }

    subject { last_response }
    let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

    it_behaves_like 'a successful API response'

    it 'returns USTDA trade event attributes' do
      expected_attributes = {
        id: 'USTDA-f0e2598dbc76ce55cd0a557746375bd911808bac',
        name: 'USTDA Trade Event Summit f0e259',
        url: 'https://example.org/trade_event?id=USTDA-f0e2598dbc76ce55cd0a557746375bd911808bac',
        source: 'USTDA',
        event_url: 'http://ustda.trade.events.example.org/event/f0e259',
        description: 'USTDA Trade Event f0e259 description.',
        cost: 25.0,
        registration_title: 'USTDA Awesome Trade Event Summit',
        registration_url: 'http://ustda.trade.events.example.org/registration/f0e259',
        start_date: '2016-05-17',
        end_date: '2016-05-24',
        countries: [
          'Taiwan',
          'United States'],
        industries: ['eCommerce Industry']
      }
      expect(parsed_body).to eq(expected_attributes)
    end
  end
end
