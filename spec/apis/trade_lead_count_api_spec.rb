require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe TradeLeadCountAPI, endpoint: '/v1/trade_leads/count' do
  include APISpecHelpers

  include_context 'elastic models',
                  TradeLead::AustraliaTradeLead,
                  TradeLead::CanadaTradeLead,
                  TradeLead::FboTradeLead,
                  TradeLead::McaTradeLead,
                  TradeLead::StateTradeLead,
                  TradeLead::UkTradeLead,
                  TradeLead::UstdaTradeLead

  include_context 'API response'

  before { get described_endpoint }

  it_behaves_like 'a successful API response'

  it 'returns metadata' do
    expect(parsed_body[:metadata]).to eq(total: 7)
  end

  it 'returns countries aggregations' do
    expected_countries = [
      { key: 'Australia', doc_count: 1 },
      { key: 'Canada', doc_count: 1 },
      { key: 'South Africa', doc_count: 3 },
      { key: 'Taiwan', doc_count: 1 },
      { key: 'United Kingdom', doc_count: 1 }
    ]
    expect(parsed_body[:aggregations][:countries]).to eq(expected_countries)
  end

  it 'returns industries aggregation' do
    expected_industries = [
      { key: '/Aerospace and Defense', doc_count: 1 },
      { key: '/Aerospace and Defense/Space', doc_count: 1 },
      { key: '/Business and Professional Services', doc_count: 1 },
      { key: '/Business and Professional Services/Scientific and Technical Services', doc_count: 1 },
      { key: '/Franchising', doc_count: 2 },
      { key: '/Information and Communication Technology', doc_count: 2 },
      { key: '/Information and Communication Technology/eCommerce Industry', doc_count: 2 },
      { key: '/Retail Trade', doc_count: 3 },
      { key: '/Retail Trade/eCommerce Industry', doc_count: 2 }
    ]
    expect(parsed_body[:aggregations][:industries]).to eq(expected_industries)
  end

  it 'returns sources aggregation' do
    expected_sources = [
      { key: 'AUSTRALIA', doc_count: 1 },
      { key: 'CANADA', doc_count: 1 },
      { key: 'FBO', doc_count: 1 },
      { key: 'MCA', doc_count: 1 },
      { key: 'STATE', doc_count: 1 },
      { key: 'UK', doc_count: 1 },
      { key: 'USTDA', doc_count: 1 }
    ]
    expect(parsed_body[:aggregations][:sources]).to eq(expected_sources)
  end
end
