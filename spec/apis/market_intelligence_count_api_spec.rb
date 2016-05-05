require 'rack_helper'

RSpec.describe MarketIntelligenceCountAPI do
  include Rack::Test::Methods

  def app
    Intrasearch::Application
  end

  include_context 'shared elastic models',
                  CountryCommercialGuide,
                  Industry,
                  MarketInsight,
                  StateReport,
                  TopMarketsReport,
                  Topic

  describe '/v1/articles/count' do
    subject { last_response }
    let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

    before { get '/v1/articles/count' }

    it_behaves_like 'API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 4)
    end

    it 'returns countries aggregation' do
      expected_countries = [
        { key: 'Canada', doc_count: 1 },
        { key: 'Czech Republic', doc_count: 1 },
        { key: 'South Africa', doc_count: 1 },
        { key: 'United States', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:countries]).to eq(expected_countries)
    end

    it 'returns industries aggregation' do
      expected_industries = [
        { key: '/Aerospace and Defense', doc_count: 1 },
        { key: '/Design and Construction', doc_count: 1 },
        { key: '/Design and Construction/Building Products', doc_count: 1 },
        { key: '/Financial Services', doc_count: 1 },
        { key: '/Financial Services/Investment Services', doc_count: 1 },
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
        { key: '/Economic Development and Investment', doc_count: 1 },
        { key: '/Economic Development and Investment/Investment', doc_count: 1 },
        { key: '/Economic Development and Investment/Investment/Foreign Investment', doc_count: 1 },
        { key: '/Trade Development and Promotion', doc_count: 1 },
        { key: '/Trade Development and Promotion/Export Potential', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:topics]).to eq(expected_topics)
    end

    it 'returns trade_regions aggregation' do
      expected_trade_regions = [
        { key: 'Asia Pacific Economic Cooperation', doc_count: 2 },
        { key: 'European Union - 28', doc_count: 1 },
        { key: 'Trans Pacific Partnership', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:trade_regions]).to eq(expected_trade_regions)
    end

    it 'returns types aggregation' do
      expected_types = [
        { key: 'Country Commercial Guide', doc_count: 1 },
        { key: 'Market Insight', doc_count: 1 },
        { key: 'State Report', doc_count: 1 },
        { key: 'Top Markets Report', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:types]).to eq(expected_types)
    end

    it 'returns world_regions aggregation' do
      expected_world_regions = [
        { key: '/Africa', doc_count: 1 },
        { key: '/Africa/Sub-Saharan Africa', doc_count: 1 },
        { key: '/Europe', doc_count: 1 },
        { key: '/North America', doc_count: 2 },
        { key: '/Pacific Rim', doc_count: 2 },
        { key: '/Western Hemisphere', doc_count: 2 }
      ]
      expect(parsed_body[:aggregations][:world_regions]).to eq(expected_world_regions)
    end
  end
end