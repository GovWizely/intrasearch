require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe PrivacyShieldArticleSearchAPI, endpoint: '/v1/privacy_shield_articles/search' do
  include APISpecHelpers

  include_context 'elastic models',
                  Article,
                  Country,
                  TradeRegion,
                  WorldRegion

  include_context 'API response'

  context 'when searching with matching query term in the title' do
    before { get described_endpoint, 'q' => 'privacy', 'limit' => 1 }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 2,
                                           count: 1,
                                           offset: 0,
                                           next_offset: 1)
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

    it 'highlights matching terms in the title' do
      expect(parsed_body[:results].count).to eq(1)

      expected_first_result = {
        id: 'ka8t0000000KzT5AAK',
        snippet: 'Cost and Benefits of the program.',
        title: '<em>Privacy</em> Shield Program',
        url: 'https://privacyshield.example.org/article?id=Privacy-Shield-Program' }
      expect(parsed_body[:results].first).to eq(expected_first_result)
    end
  end

  context 'when searching with matching query term in the atom' do
    before { get described_endpoint, 'q' => 'benefit', 'limit' => 1 }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end

    it 'highlights matching terms from the atom' do
      expect(parsed_body[:results].count).to eq(1)

      expected_first_result = {
        id: 'ka8t0000000KzT5AAK',
        snippet: 'Cost and <em>Benefits</em> of the program.',
        title: 'Privacy Shield Program',
        url: 'https://privacyshield.example.org/article?id=Privacy-Shield-Program' }
      expect(parsed_body[:results].first).to eq(expected_first_result)
    end
  end

  context 'when paginating with limit and offset' do
    before { get described_endpoint, limit: 1, offset: 1, q: 'shield' }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 2,
                                           count: 1,
                                           offset: 1,
                                           next_offset: nil)
    end
  end
end
