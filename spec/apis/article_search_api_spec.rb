require 'rack_helper'

RSpec.describe ArticleSearchAPI do
  include Rack::Test::Methods

  def app
    Nix::Application
  end

  include_context 'shared elastic models',
                  CountryCommercialGuide,
                  Generic,
                  Industry,
                  MarketInsight,
                  StateReport,
                  TopMarketsReport,
                  Topic

  describe '/v1/articles/search' do
    subject { last_response }
    let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

    context 'when searching for articles with matching query term in the title' do
      before { get '/v1/articles/search', 'q' => 'product', 'limit' => 1 }

      it_behaves_like 'API response'

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
          { key: 'South Africa', doc_count: 1 },
          { key: 'Sweden', doc_count: 1 }
        ]
        expect(parsed_body[:aggregations][:countries]).to eq(expected_countries)
      end

      it 'returns industries aggregation' do
        expected_industries = [
          { key: '/Aerospace and Defense', doc_count: 2 },
          { key: '/Aerospace and Defense/Space', doc_count: 1 },
          { key: '/Design and Construction', doc_count: 1 },
          { key: '/Design and Construction/Building Products', doc_count: 1 },
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
          { key: '/Environment', doc_count: 1 },
          { key: '/Environment/Climate', doc_count: 1 },
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
          { key: 'Generic', doc_count: 1 },
          { key: 'Market Insight', doc_count: 1 },
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

      it 'highlights matching terms from the title' do
        expect(parsed_body[:results].count).to eq(1)

        expected_first_result = {
          id: 'ka6t0000000006sAAA',
          snippet: 'Canada ranks first among top export markets for U.S. building <em>product</em> manufacturers due to its proximity, duty-free status under NAFTA, relative lack of non-tariff trade barriers, and ease of commercial relationship establishment.',
          title: 'Top Markets Building <em>Products</em> and Sustainable Construction Country Case Study Challenges and Barriers - Canada',
          url: 'https://example.org/article2?id=Top-Markets-Building-Products-and-Sustainable-Construction-Country-Case-Study-Challenges-and-Barriers-Canada' }
        expect(parsed_body[:results].first).to eq(expected_first_result)
      end
    end

    context 'when searching for articles with matching query term in the summary' do
      before { get '/v1/articles/search', 'q' => 'retail', 'limit' => 1 }

      it_behaves_like 'API response'

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

      it 'highlights matching terms from the summary' do
        expect(parsed_body[:results].count).to eq(1)

        expected_first_result = {
          id: 'ka0t0000000PCy6AAG',
          snippet: 'Describes how widely e-Commerce is used, the primary sectors that sell through e-commerce, and how much product/service in each sector is sold through e-commerce versus brick-and-mortar <em>retail</em>.',
          title: 'Czech Republic - E-Commerce',
          url: 'https://example.org/article2?id=Czech-Republic-ECommerce' }
        expect(parsed_body[:results].first).to eq(expected_first_result)
      end
    end

    context 'when searching for articles with query term in the atom' do
      before { get '/v1/articles/search', 'q' => 'household computer' }

      it_behaves_like 'API response'

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
          snippet: 'In 2014, more than two-thirds of Czech <em>households</em> had <em>computers</em>.',
          title: 'Czech Republic - E-Commerce',
          url: 'https://example.org/article2?id=Czech-Republic-ECommerce' }
        expect(parsed_body[:results].first).to eq(expected_first_result)
      end
    end

    context 'when searching for articles with countries' do
      before { get '/v1/articles/search', countries: ' canadA, bogus country, sweDen' }

      it_behaves_like 'API response'

      it 'returns matching countries aggregation' do
        expected_countries = [
          { key: 'Canada', doc_count: 1 },
          { key: 'Sweden', doc_count: 1 }
        ]
        expect(parsed_body[:aggregations][:countries]).to eq(expected_countries)
      end
    end

    context 'when searching for articles with industries' do
      before { get '/v1/articles/search', industries: 'eCommerce Industry, spacE ' }

      it_behaves_like 'API response'

      it 'returns matching industries aggregation' do
        expected_industries = [
          { key: '/Aerospace and Defense/Space', doc_count: 1 },
          { key: '/Information and Communication Technology/eCommerce Industry', doc_count: 2 },
          { key: '/Retail Trade/eCommerce Industry', doc_count: 2 }
        ]
        expect(parsed_body[:aggregations][:industries]).to eq(expected_industries)
      end
    end

    context 'when searching for articles with topics' do
      before { get '/v1/articles/search', topics: 'priceS , invalid,  climatE ' }

      it_behaves_like 'API response'

      it 'returns matching topics aggregation' do
        expected_topics = [
          { key: '/Business Management/Costing and Pricing/Prices', doc_count: 1 },
          { key: '/Environment/Climate', doc_count: 1 }
        ]
        expect(parsed_body[:aggregations][:topics]).to eq(expected_topics)
      end
    end

    context 'when searching for articles with trade regions' do
      before { get '/v1/articles/search', trade_regions: ' invalid  , Trans Pacific PartnershiP, Asia Pacific Economic CooperatioN ' }

      it_behaves_like 'API response'

      it 'returns trade_regions aggregation' do
        expected_trade_regions = [
          { key: 'Asia Pacific Economic Cooperation', doc_count: 2 },
          { key: 'Trans Pacific Partnership', doc_count: 1 }
        ]
        expect(parsed_body[:aggregations][:trade_regions]).to eq(expected_trade_regions)
      end
    end

    context 'when searching for articles with types' do
      before { get '/v1/articles/search', types: ' top  markets  REPORT , country commercial Guide' }

      it_behaves_like 'API response'

      it 'returns types aggregation' do
        expected_types = [
          { key: 'Country Commercial Guide', doc_count: 1 },
          { key: 'Top Markets Report', doc_count: 1 }
        ]
        expect(parsed_body[:aggregations][:types]).to eq(expected_types)
      end
    end

    context 'when searching for articles with world regions' do
      before { get '/v1/articles/search', world_regions: ' invalid  , pacific RIM  , westerN Hemisphere ' }

      it_behaves_like 'API response'

      it 'returns world_regions aggregation' do
        expected_world_regions = [
          { key: '/Pacific Rim', doc_count: 2 },
          { key: '/Western Hemisphere', doc_count: 2 }
        ]
        expect(parsed_body[:aggregations][:world_regions]).to eq(expected_world_regions)
      end
    end

    context 'when searching for articles with limit and offset' do
      before { get '/v1/articles/search', limit: 2, offset: 1, q: 'product' }

      it_behaves_like 'API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 4,
                                             count: 2,
                                             offset: 1,
                                             next_offset: 3)
      end
    end

    context 'when searching for articles where not all query terms are present in the index' do
      before { get '/v1/articles/search', q: 'atom market' }

      it_behaves_like 'API response'

      it 'returns empty results' do
        aggregate_failures do
          expected_metadata = {
            total: 0,
            count: 0,
            offset: 0,
            next_offset: nil
          }
          expect(parsed_body[:metadata]).to eq(expected_metadata)
          expect(parsed_body[:results]).to be_empty
        end
      end
    end
  end
end
