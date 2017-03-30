require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe MarketIntelligenceSearchAPI, endpoint: '/v1/market_intelligence_articles/search' do
  include APISpecHelpers

  include_context 'elastic models',
                  Country,
                  CountryCommercialGuide,
                  Industry,
                  MarketInsight,
                  MarketIntelligence,
                  StateReport,
                  TopMarketsReport,
                  Topic,
                  TradeRegion,
                  WorldRegion

  include_context 'API response'

  context 'when searching with matching query term in the title' do
    before { get described_endpoint, 'q' => 'product', 'limit' => 1 }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 4,
                                           count: 1,
                                           offset: 0,
                                           next_offset: 1)
    end

    it 'returns countries aggregation' do
      expected_countries = [
        { key: 'Canada', doc_count: 1 },
        { key: 'Czech Republic', doc_count: 1 },
        { key: 'France', doc_count: 1 },
        { key: 'South Africa', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:countries]).to eq(expected_countries)
    end

    it 'returns industries aggregation' do
      expected_industries = [
        { key: '/Aerospace and Defense', doc_count: 1 },
        { key: '/Design and Construction', doc_count: 1 },
        { key: '/Design and Construction/Building Products', doc_count: 1 },
        { key: '/Distribution and Logistics', doc_count: 1 },
        { key: '/Distribution and Logistics/Air Transportation', doc_count: 1 },
        { key: '/Information and Communication Technology', doc_count: 2 },
        { key: '/Information and Communication Technology/eCommerce Industry', doc_count: 2 },
        { key: '/Retail Trade', doc_count: 2 },
        { key: '/Retail Trade/eCommerce Industry', doc_count: 2 }
      ]
      expect(parsed_body[:aggregations][:industries]).to eq(expected_industries)
    end

    it 'returns topics aggregation' do
      expected_topics = [
        { key: '/Business Management', doc_count: 2 },
        { key: '/Business Management/Costing and Pricing', doc_count: 1 },
        { key: '/Business Management/Costing and Pricing/Prices', doc_count: 1 },
        { key: '/Business Management/eCommerce', doc_count: 1 },
        { key: '/Trade Development and Promotion', doc_count: 1 },
        { key: '/Trade Development and Promotion/Export Potential', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:topics]).to eq(expected_topics)
    end

    it 'returns trade_regions aggregation' do
      expected_trade_regions = [
        { key: 'Asia Pacific Economic Cooperation', doc_count: 1 },
        { key: 'European Union - 28', doc_count: 2 },
        { key: 'Trans Pacific Partnership', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:trade_regions]).to eq(expected_trade_regions)
    end

    it 'returns types aggregation' do
      expected_types = [
        { key: 'Country Commercial Guide', doc_count: 1 },
        { key: 'Market Insight', doc_count: 1 },
        { key: 'Market Intelligence', doc_count: 1 },
        { key: 'Top Markets Report', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:types]).to eq(expected_types)
    end

    it 'returns world_regions aggregation' do
      expected_world_regions = [
        { key: '/Africa', doc_count: 1 },
        { key: '/Africa/Sub-Saharan Africa', doc_count: 1 },
        { key: '/Europe', doc_count: 2 },
        { key: '/North America', doc_count: 1 },
        { key: '/Pacific Rim', doc_count: 1 },
        { key: '/Western Hemisphere', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:world_regions]).to eq(expected_world_regions)
    end

    it 'highlights matching terms in the title' do
      expect(parsed_body[:results].count).to eq(1)

      expected_first_result = {
        id: 'ka6t0000000006sAAA',
        snippet: 'The 2015 Top Markets Report for Building <em>Products</em> and Sustainable Construction ranked 75 exports markets.',
        title: 'Top Markets Building <em>Products</em> &amp; Sustainable Construction Country Case Study Challenges and Barriers - Canada',
        url: 'https://example.org/article2?id=Top-Markets-Building-Products-and-Sustainable-Construction-Country-Case-Study-Challenges-and-Barriers-Canada' }
      expect(parsed_body[:results].first).to eq(expected_first_result)
    end
  end

  context 'when searching with matching query term in the summary' do
    before { get described_endpoint, 'q' => 'retail', 'limit' => 1 }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end

    it 'returns countries aggregation' do
      expected_countries = [
        { key: 'Czech Republic', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:countries]).to eq(expected_countries)
    end

    it 'returns industries aggregation' do
      expected_industries = [
        { key: '/Aerospace and Defense', doc_count: 1 },
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
        { key: '/Business Management/Costing and Pricing', doc_count: 1 },
        { key: '/Business Management/Costing and Pricing/Prices', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:topics]).to eq(expected_topics)
    end

    it 'returns trade_regions aggregation' do
      expected_trade_regions = [
        { key: 'European Union - 28', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:trade_regions]).to eq(expected_trade_regions)
    end

    it 'returns types aggregation' do
      expected_types = [
        { key: 'Country Commercial Guide', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:types]).to eq(expected_types)
    end

    it 'returns world_regions aggregation' do
      expected_world_regions = [
        { key: '/Europe', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:world_regions]).to eq(expected_world_regions)
    end

    it 'renders truncated atom without highlighting in the snippet' do
      expect(parsed_body[:results].count).to eq(1)

      expected_first_result = {
        id: 'ka0t0000000PCy6AAG',
        snippet: 'In 2014, more than two-thirds of Czech households had computers. Over 78 percent of the population had access to the Internet and 76 percent of households had broadband internet connections (according to Eurostat). The number of Czech consumers shopping ...',
        title: 'Czech Republic - E-Commerce',
        url: 'https://example.org/article2?id=Czech-Republic-ECommerce' }
      expect(parsed_body[:results].first).to eq(expected_first_result)
    end
  end

  context 'when searching with query term in the atom' do
    before { get described_endpoint, 'q' => 'household computer' }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end

    it 'returns countries aggregation' do
      expected_countries = [
        { key: 'Czech Republic', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:countries]).to eq(expected_countries)
    end

    it 'returns industries aggregation' do
      expected_industries = [
        { key: '/Aerospace and Defense', doc_count: 1 },
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
        { key: '/Business Management/Costing and Pricing', doc_count: 1 },
        { key: '/Business Management/Costing and Pricing/Prices', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:topics]).to eq(expected_topics)
    end

    it 'returns trade_regions aggregation' do
      expected_trade_regions = [
        { key: 'European Union - 28', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:trade_regions]).to eq(expected_trade_regions)
    end

    it 'returns types aggregation' do
      expected_types = [
        { key: 'Country Commercial Guide', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:types]).to eq(expected_types)
    end

    it 'returns world_regions aggregation' do
      expected_world_regions = [
        { key: '/Europe', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:world_regions]).to eq(expected_world_regions)
    end

    it 'highlights matching terms from the atom' do
      expect(parsed_body[:results].count).to eq(1)

      expected_first_result = {
        id: 'ka0t0000000PCy6AAG',
        snippet: 'In 2014, more than two-thirds of Czech <em>households</em> had <em>computers</em>. Over 78 percent of the population had access to the Internet and 76 percent of <em>households</em> had broadband internet connections (according to Eurostat). The number of Czech consumers shopping ...',
        title: 'Czech Republic - E-Commerce',
        url: 'https://example.org/article2?id=Czech-Republic-ECommerce' }
      expect(parsed_body[:results].first).to eq(expected_first_result)
    end
  end

  context 'when searching with country name in the query' do
    before { get described_endpoint, q: 'united States' }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end
  end

  context 'when searching with trade region name in the query' do
    before { get described_endpoint, q: 'Asia Pacific Economic Cooperation product' }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end
  end

  context 'when searching with world region name in the query' do
    before { get described_endpoint, q: 'north america' }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 2,
                                           count: 2,
                                           offset: 0,
                                           next_offset: nil)
    end
  end

  context 'when searching with HTML entity name in the query' do
    before { get described_endpoint, q: 'amp' }

    it_behaves_like 'a successful API response'

    it 'returns empty results' do
      expect(parsed_body[:results]).to be_empty
    end
  end

  context 'when searching with some query terms that are not present in the index' do
    before { get described_endpoint, q: 'atom market' }

    it_behaves_like 'a successful API response'
    it_behaves_like 'an empty metadata and results response'
  end

  context 'when filtering with countries' do
    before { get described_endpoint, countries: ' Canada, bogus country, Czech Republic' }

    it_behaves_like 'a successful API response'

    it 'returns matching countries aggregation' do
      expected_countries = [
        { key: 'Canada', doc_count: 1 },
        { key: 'Czech Republic', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:countries]).to eq(expected_countries)
    end
  end

  context 'when filtering with industries' do
    before { get described_endpoint, industries: 'eCommerce Industry, bogus industry ' }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 2,
                                           count: 2,
                                           offset: 0,
                                           next_offset: nil)
    end

    it 'returns industries aggregation' do
      expected_industries = [
        { key: '/Aerospace and Defense', doc_count: 1 },
        { key: '/Information and Communication Technology', doc_count: 2 },
        { key: '/Information and Communication Technology/eCommerce Industry', doc_count: 2 },
        { key: '/Retail Trade', doc_count: 2 },
        { key: '/Retail Trade/eCommerce Industry', doc_count: 2 }
      ]
      expect(parsed_body[:aggregations][:industries]).to eq(expected_industries)
    end
  end

  context 'when filtering with topics' do
    before { get described_endpoint, topics: 'Prices , invalid ' }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end

    it 'returns matching topics aggregation' do
      expected_topics = [
        { key: '/Business Management', doc_count: 1 },
        { key: '/Business Management/Costing and Pricing', doc_count: 1 },
        { key: '/Business Management/Costing and Pricing/Prices', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:topics]).to eq(expected_topics)
    end
  end

  context 'when filtering with trade regions' do
    before { get described_endpoint, trade_regions: ' invalid  , Trans Pacific Partnership , Asia Pacific Economic Cooperation ' }

    it_behaves_like 'a successful API response'

    it 'returns trade_regions aggregation' do
      expected_trade_regions = [
        { key: 'Asia Pacific Economic Cooperation', doc_count: 2 },
        { key: 'Trans Pacific Partnership', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:trade_regions]).to eq(expected_trade_regions)
    end
  end

  context 'when filtering with world regions' do
    before { get described_endpoint, world_regions: ' invalid  , Pacific Rim  ' }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 2,
                                           count: 2,
                                           offset: 0,
                                           next_offset: nil)
    end

    it 'returns world_regions aggregation' do
      expected_world_regions = [
        { key: '/North America', doc_count: 2 },
        { key: '/Pacific Rim', doc_count: 2 },
        { key: '/Western Hemisphere', doc_count: 2 }
      ]
      expect(parsed_body[:aggregations][:world_regions]).to eq(expected_world_regions)
    end
  end

  context 'when paginating with limit and offset' do
    before { get described_endpoint, limit: 1, offset: 1, q: 'product' }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 4,
                                           count: 1,
                                           offset: 1,
                                           next_offset: 2)
    end
  end

  context 'when searching for a stemmed word' do
    before { get described_endpoint, q: 'firefight' }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end
  end
end
