require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe StopFakesArticleSearchAPI, endpoint: '/v1/stop_fakes_articles/search' do
  include APISpecHelpers

  include_context 'elastic models',
                  Article,
                  Country,
                  TradeRegion,
                  WorldRegion

  include_context 'API response'

  context 'when searching with matching query term in the title' do
    before { get described_endpoint, 'q' => 'goods', 'limit' => 1 }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end

    it 'returns countries aggregation' do
      expected_countries = [
        { key: 'Australia', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:countries]).to eq(expected_countries)
    end

    it 'returns industries aggregation' do
      expect(parsed_body[:aggregations][:industries]).to be_empty
    end

    it 'returns topics aggregation' do
      expected_topics = [
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

    it 'highlights matching terms in the title' do
      expect(parsed_body[:results].count).to eq(1)

      expected_first_result = {
        id: 'ka8t0000000GnCrAAK',
        snippet: 'General Business Information As a result of the U.S.-Australia Free Trade Agreement, tariffs that averaged 4.3 percent were eliminated on more than 99% of the tariff lines for U.S. manufactured <em>goods</em> exports to Australia.',
        title: '<em>Goods</em> US-Australia FTA',
        url: 'https://stopfakes.example.org/article?id=U-S-Australia-FTA' }
      expect(parsed_body[:results].first).to eq(expected_first_result)
    end
  end

  context 'when searching with matching query term in the summary' do
    before { get described_endpoint, 'q' => 'global', 'limit' => 1 }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end

    it 'renders truncated atom without highlighting in the snippet' do
      expect(parsed_body[:results].count).to eq(1)

      expected_first_result = {
        id: 'ka8t0000000Gn7mAAC',
        snippet: 'Trust in online sellers is reasonably high everywhere except Asia, according to a study sponsored by UPS, the logistics company.',
        title: 'Duties &amp; Taxes',
        url: 'https://stopfakes.example.org/article?id=Duties-and-Taxes-eCommerce-Guide-2' }
      expect(parsed_body[:results].first).to eq(expected_first_result)
    end
  end

  context 'when searching with matching query term in the atom' do
    before { get described_endpoint, 'q' => 'logistics', 'limit' => 1 }

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
        id: 'ka8t0000000Gn7mAAC',
        snippet: 'Trust in online sellers is reasonably high everywhere except Asia, according to a study sponsored by UPS, the <em>logistics</em> company.',
        title: 'Duties &amp; Taxes',
        url: 'https://stopfakes.example.org/article?id=Duties-and-Taxes-eCommerce-Guide-2' }
      expect(parsed_body[:results].first).to eq(expected_first_result)
    end
  end

  context 'when searching with country name in the query' do
    before { get described_endpoint, q: 'australia' }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end
  end

  context 'when searching with trade region name in the query' do
    before { get described_endpoint, q: 'Asia Pacific Economic Cooperation' }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end
  end

  context 'when searching with world region name in the query' do
    before { get described_endpoint, q: 'Oceania' }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end
  end

  context 'when searching with HTML entity name in the query' do
    before { get described_endpoint, q: 'amp' }

    it_behaves_like 'a successful API response'
    it_behaves_like 'an empty metadata and results response'
  end

  context 'when searching with some query terms that are not present in the index' do
    before { get described_endpoint, q: 'atom nafta' }

    it_behaves_like 'a successful API response'
    it_behaves_like 'an empty metadata and results response'
  end

  context 'when filtering with countries' do
    before { get described_endpoint, countries: 'Australia, bogus country' }

    it_behaves_like 'a successful API response'

    it 'returns matching countries aggregation' do
      expected_countries = [
        { key: 'Australia', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:countries]).to eq(expected_countries)
    end
  end

  context 'when filtering with industries' do
    before { get described_endpoint, industries: 'eCommerce Industry, bogus industry ' }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
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
  end

  context 'when filtering with topics' do
    before { get described_endpoint, topics: 'Free Trade Agreements , invalid ' }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end

    it 'returns matching topics aggregation' do
      expected_topics = [
        { key: '/Trade Policy and Agreements', doc_count: 1 },
        { key: '/Trade Policy and Agreements/Trade Agreements', doc_count: 1 },
        { key: '/Trade Policy and Agreements/Trade Agreements/Free Trade Agreements', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:topics]).to eq(expected_topics)
    end
  end

  context 'when filtering with trade regions' do
    before { get described_endpoint, trade_regions: ' invalid  , Trans Pacific Partnership, Asia Pacific Economic Cooperation ' }

    it_behaves_like 'a successful API response'

    it 'returns trade_regions aggregation' do
      expected_trade_regions = [
        { key: 'Asia Pacific Economic Cooperation', doc_count: 1 },
        { key: 'Trans Pacific Partnership', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:trade_regions]).to eq(expected_trade_regions)
    end
  end

  context 'when filtering with world regions' do
    before { get described_endpoint, world_regions: ' invalid  , Pacific Rim  , Western Hemisphere ' }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
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

  context 'when paginating with limit and offset' do
    before { get described_endpoint, limit: 1, offset: 1, q: 'business' }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 2,
                                           count: 1,
                                           offset: 1,
                                           next_offset: nil)
    end
  end
end
