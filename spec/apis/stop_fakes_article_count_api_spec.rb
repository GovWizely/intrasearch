require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe StopFakesArticleCountAPI, endpoint: '/v1/stop_fakes_articles/count' do
  include APISpecHelpers

  include_context 'elastic models',
                  Article

  include_context 'API response'

  before { get described_endpoint }

  it_behaves_like 'a successful API response'

  it 'returns metadata' do
    expect(parsed_body[:metadata]).to eq(total: 2)
  end

  it 'returns countries aggregation' do
    expected_countries = [
      { key: 'Australia', doc_count: 1 }
    ]
    expect(parsed_body[:aggregations][:countries]).to eq(expected_countries)
  end

  it 'returns industries aggregation' do
    expected_industries = [
      { key: '/Information and Communication Technology', doc_count: 1 },
      { key: '/Information and Communication Technology/eCommerce Industry', doc_count: 1 },
      { key: '/Retail Trade', doc_count: 1 },
      { key: '/Retail Trade/eCommerce Industry', doc_count: 1 }
    ]
    expect(parsed_body[:aggregations][:industries]).to eq(expected_industries)
  end

  it 'returns topics aggregation' do
    expected_topics = [
      { key: '/Business Management', doc_count: 1 },
      { key: '/Business Management/eCommerce', doc_count: 1 },
      { key: '/Trade Policy and Agreements', doc_count: 1 },
      { key: '/Trade Policy and Agreements/Trade Agreements', doc_count: 1 },
      { key: '/Trade Policy and Agreements/Trade Agreements/Free Trade Agreements', doc_count: 1 }
    ]
    expect(parsed_body[:aggregations][:topics]).to eq(expected_topics)
  end

  it 'returns trade_regions aggregation' do
    expected_trade_regions = [
      { key: 'Asia Pacific Economic Cooperation', doc_count: 1 },
      { key: 'Trans Pacific Partnership', doc_count: 1 }
    ]
    expect(parsed_body[:aggregations][:trade_regions]).to eq(expected_trade_regions)
  end

  it 'returns world_regions aggregation' do
    expected_world_regions = [
      { key: '/Asia Pacific', doc_count: 1 },
      { key: '/Oceania', doc_count: 1 },
      { key: '/Pacific Rim', doc_count: 1 }
    ]
    expect(parsed_body[:aggregations][:world_regions]).to eq(expected_world_regions)
  end
end
