require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe TradeEventCountAPI, endpoint: '/v1/trade_events/count' do
  include APISpecHelpers

  include_context 'elastic models',
                  TradeEvent::DlTradeEvent,
                  TradeEvent::ItaTradeEvent,
                  TradeEvent::SbaTradeEvent,
                  TradeEvent::UstdaTradeEvent

  include_context 'API response'

  before { get described_endpoint }

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

  it 'returns event types aggregation' do
    expected_countries = [
      { key: 'Resource Partner', doc_count: 1 },
      { key: 'Trade Mission', doc_count: 1 }
    ]
    expect(parsed_body[:aggregations][:event_types]).to eq(expected_countries)
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
end
