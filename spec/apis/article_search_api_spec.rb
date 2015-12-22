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

    context 'when q parameter is present' do
      before { get '/v1/articles/search', 'q' => 'commerce', 'limit' => 1 }

      it 'returns response' do
        aggregate_failures do
          expect(last_response.status).to eq(200)

          expect(parsed_body[:metadata]).to eq(total: 3,
                                               count: 1,
                                               offset: 0,
                                               next_offset: 1)

          expected_aggregations = {
            industries: [
              { key: '/Aerospace and Defense', doc_count: 2 },
              { key: '/Aerospace and Defense/Space', doc_count: 1 },
              { key: '/Information and Communication Technology', doc_count: 2 },
              { key: '/Information and Communication Technology/eCommerce Industry', doc_count: 2 }
            ],
            countries: [
              { key: 'Cayman Islands', doc_count: 1 },
              { key: 'Czech Republic', doc_count: 1 },
              { key: 'Sweden', doc_count: 1 }
            ],
            types: [
              { key: 'Country Commercial Guide', doc_count: 1 },
              { key: 'Generic', doc_count: 1 },
              { key: 'Market Insight', doc_count: 1 }
            ],
            topics: [
              { key: '/Business Management', doc_count: 2 },
              { key: '/Business Management/Costing and Pricing', doc_count: 1 },
              { key: '/Business Management/Costing and Pricing/Prices', doc_count: 1 },
              { key: '/Business Management/eCommerce', doc_count: 1 },
              { key: '/Environment', doc_count: 1 },
              { key: '/Environment/Climate', doc_count: 1 }
            ]
          }
          expect(parsed_body[:aggregations]).to eq(expected_aggregations)

          expect(parsed_body[:results].count).to eq(1)

          expected_first_result = {
            countries: ['Czech Republic'],
            id: 'ka0t0000000PCy6AAG',
            industries: ['Aerospace and Defense', 'eCommerce Industry'],
            snippet: 'Describes how widely e-<em>Commerce</em> is used, the primary sectors that sell through e-<em>commerce</em>, and how much product/service in each sector is sold through e-<em>commerce</em> versus brick-and-mortar retail.',
            title: 'Czech Republic - E-<em>Commerce</em>',
            topics: ['Prices'],
            type: 'Country Commercial Guide',
            url: 'https://example.org/article2?id=Czech-Republic-ECommerce' }
          expect(parsed_body[:results].first).to eq(expected_first_result)
        end
      end
    end

    context 'when countries parameter is present' do
      before { get '/v1/articles/search', countries: ' CaymaN IslandS, Latvia , thailand , canadA, bogus country, sweDen, uniteD stateS' }

      it 'returns response' do
        aggregate_failures do
          expect(last_response.status).to eq(200)

          expected_metadata = {
            total: 6,
            count: 6,
            offset: 0,
            next_offset: nil
          }
          expect(parsed_body[:metadata]).to eq(expected_metadata)

          expected_aggregations = {
            countries: [
              { key: 'Canada', doc_count: 1 },
              { key: 'Cayman Islands', doc_count: 1 },
              { key: 'Latvia', doc_count: 1 },
              { key: 'Sweden', doc_count: 1 },
              { key: 'Thailand', doc_count: 1 },
              { key: 'United States', doc_count: 1 }
            ],
            industries: [
              { key: '/Aerospace and Defense', doc_count: 1 },
              { key: '/Aerospace and Defense/Space', doc_count: 1 },
              { key: '/Agribusiness', doc_count: 1 },
              { key: '/Agribusiness/Forestry Equipment and Machinery', doc_count: 1 },
              { key: '/Design and Construction', doc_count: 1 },
              { key: '/Design and Construction/Building Products', doc_count: 1 },
              { key: '/Equipment and Machinery', doc_count: 1 },
              { key: '/Financial Services', doc_count: 1 },
              { key: '/Financial Services/Investment Services', doc_count: 1 },
              { key: '/Franchising', doc_count: 1 },
              { key: '/Information and Communication Technology', doc_count: 1 },
              { key: '/Information and Communication Technology/eCommerce Industry', doc_count: 1 }
            ],
            types: [
              { key: 'Country Commercial Guide', doc_count: 2 },
              { key: 'Generic', doc_count: 1 },
              { key: 'Market Insight', doc_count: 1 },
              { key: 'State Report', doc_count: 1 },
              { key: 'Top Markets Report', doc_count: 1 }
            ],
            topics: [
              { key: '/Business Management', doc_count: 1 },
              { key: '/Business Management/eCommerce', doc_count: 1 },
              { key: '/Economic Development and Investment', doc_count: 1 },
              { key: '/Economic Development and Investment/Investment', doc_count: 1 },
              { key: '/Economic Development and Investment/Investment/Foreign Investment', doc_count: 1 },
              { key: '/Environment', doc_count: 1 },
              { key: '/Environment/Climate', doc_count: 1 },
              { key: '/Trade Development and Promotion', doc_count: 3 },
              { key: '/Trade Development and Promotion/Export Potential', doc_count: 1 },
              { key: '/Trade Development and Promotion/Exports', doc_count: 1 },
              { key: '/Trade Development and Promotion/Trade Promotion', doc_count: 1 }
            ]
          }
          expect(parsed_body[:aggregations]).to eq(expected_aggregations)
        end
      end
    end

    context 'when industries parameter is present' do
      before { get '/v1/articles/search', industries: 'eCommerce Industry, spacE ' }

      it 'returns results' do
        aggregate_failures do
          expect(last_response.status).to eq(200)

          expected_metadata = {
            total: 3,
            count: 3,
            offset: 0,
            next_offset: nil
          }
          expect(parsed_body[:metadata]).to eq(expected_metadata)

          expected_aggregations = {
            countries: [
              { key: 'Cayman Islands', doc_count: 1 },
              { key: 'Czech Republic', doc_count: 1 },
              { key: 'Sweden', doc_count: 1 }
            ],
            industries: [
              { key: '/Aerospace and Defense/Space', doc_count: 1 },
              { key: '/Information and Communication Technology/eCommerce Industry', doc_count: 2 }
            ],
            types: [
              { key: 'Country Commercial Guide', doc_count: 1 },
              { key: 'Generic', doc_count: 1 },
              { key: 'Market Insight', doc_count: 1 }
            ],
            topics: [
              { key: '/Business Management', doc_count: 2 },
              { key: '/Business Management/Costing and Pricing', doc_count: 1 },
              { key: '/Business Management/Costing and Pricing/Prices', doc_count: 1 },
              { key: '/Business Management/eCommerce', doc_count: 1 },
              { key: '/Environment', doc_count: 1 },
              { key: '/Environment/Climate', doc_count: 1 }
            ]
          }
          expect(parsed_body[:aggregations]).to eq(expected_aggregations)
        end
      end
    end

    context 'when types parameter is present' do
      before { get '/v1/articles/search', types: ' top  markets  REPORT ' }

      it 'returns results' do
        aggregate_failures do
          expect(last_response.status).to eq(200)

          expected_metadata = {
            total: 1,
            count: 1,
            offset: 0,
            next_offset: nil
          }
          expect(parsed_body[:metadata]).to eq(expected_metadata)

          expected_aggregations = {
            countries: [
              { key: 'Canada', doc_count: 1 }
            ],
            industries: [
              { key: '/Design and Construction', doc_count: 1 },
              { key: '/Design and Construction/Building Products', doc_count: 1 }
            ],
            types: [
              { key: 'Top Markets Report', doc_count: 1 },
            ],
            topics: [
              { key: '/Trade Development and Promotion', doc_count: 1 },
              { key: '/Trade Development and Promotion/Export Potential', doc_count: 1 }
            ]
          }
          expect(parsed_body[:aggregations]).to eq(expected_aggregations)
        end
      end
    end

    context 'when topics parameter is present' do
      before { get '/v1/articles/search', topics: 'priceS , capitaL,  climatE ' }

      it 'returns results' do
        aggregate_failures do
          expect(last_response.status).to eq(200)

          expected_metadata = {
            total: 3,
            count: 3,
            offset: 0,
            next_offset: nil
          }
          expect(parsed_body[:metadata]).to eq(expected_metadata)

          expected_aggregations = {
            countries: [
              { key: 'Czech Republic', doc_count: 1 },
              { key: 'South Africa', doc_count: 1 },
              { key: 'Sweden', doc_count: 1 }
            ],
            industries: [
              { key: '/Aerospace and Defense', doc_count: 2 },
              { key: '/Aerospace and Defense/Space', doc_count: 1 },
              { key: '/Franchising', doc_count: 1 },
              { key: '/Information and Communication Technology', doc_count: 1 },
              { key: '/Information and Communication Technology/eCommerce Industry', doc_count: 1 }
            ],
            types: [
              { key: 'Country Commercial Guide', doc_count: 2 },
              { key: 'Generic', doc_count: 1 }
            ],
            topics: [
              { key: '/Business Management/Costing and Pricing/Prices', doc_count: 1 },
              { key: '/Economic Development and Investment/Capital', doc_count: 1 },
              { key: '/Environment/Climate', doc_count: 1 }
            ]
          }
          expect(parsed_body[:aggregations]).to eq(expected_aggregations)
        end
      end
    end

    context 'when searching with offset' do
      before { get '/v1/articles/search', q: 'south africa', offset: '1' }

      it 'returns matching CountryCommercial' do
        aggregate_failures do
          expect(last_response.status).to eq(200)
          expected_metadata = {
            total: 2,
            count: 1,
            offset: 1,
            next_offset: nil
          }
          expect(parsed_body[:metadata]).to eq(expected_metadata)
        end
      end
    end

    context 'when not all query terms are present in the index' do
      before { get '/v1/articles/search', q: 'atom market' }

      it 'returns empty results' do
        aggregate_failures do
          expect(last_response.status).to eq(200)
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
