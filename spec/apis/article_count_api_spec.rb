require 'rack_helper'

RSpec.describe ArticleCountAPI do
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

  describe '/v1/articles/count' do
    subject { last_response }
    let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

    before { get '/v1/articles/count' }

    it 'returns response' do
      aggregate_failures do
        expect(last_response.status).to eq(200)

        expect(parsed_body[:metadata]).to eq(total: 5)

        expected_aggregations = {
          countries: [
            { key: 'Canada', doc_count: 1 },
            { key: 'Czech Republic', doc_count: 1 },
            { key: 'South Africa', doc_count: 1 },
            { key: 'Sweden', doc_count: 1 },
            { key: 'United States', doc_count: 1 }
          ],
          industries: [
            { key: '/Aerospace and Defense', doc_count: 2 },
            { key: '/Aerospace and Defense/Space', doc_count: 1 },
            { key: '/Design and Construction', doc_count: 1 },
            { key: '/Design and Construction/Building Products', doc_count: 1 },
            { key: '/Financial Services', doc_count: 1 },
            { key: '/Financial Services/Investment Services', doc_count: 1 },
            { key: '/Information and Communication Technology', doc_count: 2 },
            { key: '/Information and Communication Technology/eCommerce Industry', doc_count: 2 }
          ],
          topics: [
            { key: '/Business Management', doc_count: 2 },
            { key: '/Business Management/Costing and Pricing', doc_count: 1 },
            { key: '/Business Management/Costing and Pricing/Prices', doc_count: 1 },
            { key: '/Business Management/eCommerce', doc_count: 1 },
            { key: '/Economic Development and Investment', doc_count: 1 },
            { key: '/Economic Development and Investment/Investment', doc_count: 1 },
            { key: '/Economic Development and Investment/Investment/Foreign Investment', doc_count: 1 },
            { key: '/Environment', doc_count: 1 },
            { key: '/Environment/Climate', doc_count: 1 },
            { key: '/Trade Development and Promotion', doc_count: 1 },
            { key: '/Trade Development and Promotion/Export Potential', doc_count: 1 }
          ],
          trade_regions: [
            { key: 'Asia Pacific Economic Cooperation', doc_count: 2 },
            { key: 'European Union - 28', doc_count: 2 },
            { key: 'Trans Pacific Partnership', doc_count: 1 }
          ],
          types: [
            { key: 'Country Commercial Guide', doc_count: 1 },
            { key: 'Generic', doc_count: 1 },
            { key: 'Market Insight', doc_count: 1 },
            { key: 'State Report', doc_count: 1 },
            { key: 'Top Markets Report', doc_count: 1 }
          ]
        }

        expect(parsed_body[:aggregations]).to eq(expected_aggregations)
      end
    end
  end
end
