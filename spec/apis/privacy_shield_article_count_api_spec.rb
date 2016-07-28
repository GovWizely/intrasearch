require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe PrivacyShieldArticleCountAPI, endpoint: '/v1/privacy_shield_articles/count' do
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
    expect(parsed_body[:aggregations][:countries]).to be_empty
  end

  it 'returns industries aggregation' do
    expect(parsed_body[:aggregations][:industries]).to be_empty
  end

  it 'returns topics aggregation' do
    expect(parsed_body[:aggregations][:topics]).to be_empty
  end

  it 'returns trade_regions aggregation' do
    expect(parsed_body[:aggregations][:trade_regions]).to be_empty
  end

  it 'returns world_regions aggregation' do
    expect(parsed_body[:aggregations][:world_regions]).to be_empty
  end
end
