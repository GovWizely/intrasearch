require 'support/api_shared_examples'
require 'support/elastic_model_shared_contexts'

RSpec.describe TradeEventSearchAPI do
  include Rack::Test::Methods

  def app
    Intrasearch::Application
  end

  include_context 'elastic models',
                  Country,
                  TradeEvent::DlTradeEvent,
                  TradeEvent::ItaTradeEvent,
                  TradeEvent::SbaTradeEvent,
                  TradeEvent::UstdaTradeEvent,
                  WorldRegion

  describe '/v1/trade_events/search' do
    let(:endpoint) { '/v1/trade_events/search' }
    subject { last_response }
    let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

    context 'when searching for trade events with matching query term in the name' do
      before { get endpoint, 'q' => 'event', 'limit' => 1 }

      it_behaves_like 'a successful API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 4,
                                             count: 1,
                                             offset: 0,
                                             next_offset: 1)
      end

      it 'returns countries aggregations' do
        expected_countries = [
          { key: 'Taiwan', doc_count: 1 },
          { key: 'United States', doc_count: 3 }
        ]
        expect(parsed_body[:aggregations][:countries]).to eq(expected_countries)
      end

      it 'returns industries aggregation' do
        expected_industries = [
          { key: '/Franchising', doc_count: 1 },
          { key: '/Information and Communication Technology', doc_count: 2 },
          { key: '/Information and Communication Technology/eCommerce Industry', doc_count: 2 },
          { key: '/Retail Trade', doc_count: 2 },
          { key: '/Retail Trade/eCommerce Industry', doc_count: 2 }
        ]
        expect(parsed_body[:aggregations][:industries]).to eq(expected_industries)
      end

      it 'returns sources aggregation' do
        expected_sources = [
          { key: 'DL', doc_count: 1 },
          { key: 'ITA', doc_count: 1 },
          { key: 'SBA', doc_count: 1 },
          { key: 'USTDA', doc_count: 1 }
        ]
        expect(parsed_body[:aggregations][:sources]).to eq(expected_sources)
      end

      it 'returns trade_regions aggregation' do
        expected_trade_regions = [
          { key: 'Asia Pacific Economic Cooperation', doc_count: 3 },
          { key: 'NAFTA', doc_count: 1 }
        ]
        expect(parsed_body[:aggregations][:trade_regions]).to eq(expected_trade_regions)
      end

      it 'returns world_regions aggregation' do
        expected_world_regions = [
          { key: '/Asia', doc_count: 1 },
          { key: '/Asia/East Asia', doc_count: 1 },
          { key: '/North America', doc_count: 3 },
          { key: '/Pacific Rim', doc_count: 3 },
          { key: '/Western Hemisphere', doc_count: 3 }
        ]
        expect(parsed_body[:aggregations][:world_regions]).to eq(expected_world_regions)
      end

      it 'highlights matching term in the title' do
        expected_first_result = {
          snippet: '<em>Event</em> 36282 description.',
          title: 'Trade <em>Event</em> 36282',
          url: 'https://example.org/trade_event?id=36282' }
        expect(parsed_body[:results].first).to eq(expected_first_result)
      end
    end

    context 'when searching for trade events with matching query term in the description' do
      before { get endpoint, 'q' => 'embassy', 'limit' => 1 }

      it_behaves_like 'a successful API response'

      it 'highlights matching term in the description' do
        expected_first_result = {
          snippet: 'Direct Line:A Political and Economic Update Bureau of Economic and Business Affairs. Register to receive information on future Direct Line calls. Brief Description of call: The U.S. <em>Embassy</em> presents an opportunity for U.S. businesses of all sizes ...',
          title: 'DL Trade Event 1',
          url: 'https://example.org/trade_event?id=94c68284a1b7698becdcdaa69dda29bb2d76051c' }
        expect(parsed_body[:results].first).to eq(expected_first_result)
      end
    end

    context 'when searching for trade events with matching query term in the venue' do
      before { get endpoint, 'q' => 'council', 'limit' => 1 }

      it_behaves_like 'a successful API response'

      it 'returns unhighlighted title and snippet' do
        expected_first_result = {
          snippet: 'SBA Trade Event 73022 description.',
          title: 'SBA Trade Event 73022',
          url: 'https://example.org/trade_event?id=730226ea901d6c4bf7e4e4f5ef12ebec8c482a2b' }
        expect(parsed_body[:results].first).to eq(expected_first_result)
      end
    end

    context 'when searching for trade events with country name in the query' do
      before { get endpoint, 'q' => 'Taiwan', 'limit' => 1 }

      it_behaves_like 'a successful API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 1,
                                             count: 1,
                                             offset: 0,
                                             next_offset: nil)
      end

      it 'returns unhighlighted title and snippet' do
        expected_first_result = {
          snippet: 'USTDA Trade Event f0e259 description.',
          title: 'USTDA Trade Event Summit f0e259',
          url: 'https://example.org/trade_event?id=f0e2598dbc76ce55cd0a557746375bd911808bac' }
        expect(parsed_body[:results].first).to eq(expected_first_result)
      end
    end

    context 'when searching for trade events with world region in the query' do
      before { get endpoint, 'q' => 'East Asia', 'limit' => 1 }

      it_behaves_like 'a successful API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 1,
                                             count: 1,
                                             offset: 0,
                                             next_offset: nil)
      end

      it 'returns unhighlighted title and snippet' do
        expected_first_result = {
          snippet: 'USTDA Trade Event f0e259 description.',
          title: 'USTDA Trade Event Summit f0e259',
          url: 'https://example.org/trade_event?id=f0e2598dbc76ce55cd0a557746375bd911808bac' }
        expect(parsed_body[:results].first).to eq(expected_first_result)
      end
    end

    context 'when filtering with countries' do
      before { get endpoint, 'countries' => 'Taiwan', 'limit' => 1 }

      it_behaves_like 'a successful API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 1,
                                             count: 1,
                                             offset: 0,
                                             next_offset: nil)
      end

      it 'returns unhighlighted title and snippet' do
        expected_first_result = {
          snippet: 'USTDA Trade Event f0e259 description.',
          title: 'USTDA Trade Event Summit f0e259',
          url: 'https://example.org/trade_event?id=f0e2598dbc76ce55cd0a557746375bd911808bac' }
        expect(parsed_body[:results].first).to eq(expected_first_result)
      end
    end


    context 'when filtering with industries' do
      before { get endpoint, 'industries' => 'Franchising', 'limit' => 1 }

      it_behaves_like 'a successful API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 1,
                                             count: 1,
                                             offset: 0,
                                             next_offset: nil)
      end

      it 'returns unhighlighted title and snippet' do
        expected_first_result = {
          snippet: 'Event 36282 description.',
          title: 'Trade Event 36282',
          url: 'https://example.org/trade_event?id=36282' }
        expect(parsed_body[:results].first).to eq(expected_first_result)
      end
    end

    context 'when filtering with trade regions' do
      before { get endpoint, 'trade_regions' => 'NAFTA', 'limit' => 1 }

      it_behaves_like 'a successful API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 1,
                                             count: 1,
                                             offset: 0,
                                             next_offset: nil)
      end

      it 'returns unhighlighted title and snippet' do
        expected_first_result = {
          snippet: 'Event 36282 description.',
          title: 'Trade Event 36282',
          url: 'https://example.org/trade_event?id=36282' }
        expect(parsed_body[:results].first).to eq(expected_first_result)
      end
    end

    context 'when filtering with world_regions' do
      before { get endpoint, 'world_regions' => 'East Asia', 'limit' => 1 }

      it_behaves_like 'a successful API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 1,
                                             count: 1,
                                             offset: 0,
                                             next_offset: nil)
      end

      it 'returns unhighlighted title and snippet' do
        expected_first_result = {
          snippet: 'USTDA Trade Event f0e259 description.',
          title: 'USTDA Trade Event Summit f0e259',
          url: 'https://example.org/trade_event?id=f0e2598dbc76ce55cd0a557746375bd911808bac' }
        expect(parsed_body[:results].first).to eq(expected_first_result)
      end
    end

    context 'when paginating with offset and limit' do
      before { get endpoint, 'q' => 'event', 'limit' => 2, 'offset' => 1 }

      it_behaves_like 'a successful API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 4,
                                             count: 2,
                                             offset: 1,
                                             next_offset: 3)
      end
    end
  end
end
