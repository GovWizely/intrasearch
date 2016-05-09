require 'support/api_shared_examples'
require 'support/elastic_model_shared_contexts'

RSpec.describe TradeEventCountAPI do
  include Rack::Test::Methods

  def app
    Intrasearch::Application
  end

  include_context 'elastic models',
                  TradeEvent::DlTradeEvent,
                  TradeEvent::ItaTradeEvent,
                  TradeEvent::SbaTradeEvent,
                  TradeEvent::UstdaTradeEvent

  describe '/v1/trade_events/count' do
    before { get '/v1/trade_events/count' }

    subject { last_response }
    let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 4)
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
  end
end
