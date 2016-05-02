require 'rack_helper'

RSpec.describe HowToArticleCountAPI do
  include Rack::Test::Methods

  def app
    Intrasearch::Application
  end

  def endpoint
    '/v1/how_to_articles/count'
  end

  include_context 'shared elastic models',
                  Article,
                  BasicGuideToExporting,
                  Country,
                  Faq,
                  WorldRegion

  describe '/v1/how_to_articles/count' do
    before { get '/v1/how_to_articles/count' }
    subject { last_response }

    let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

    it_behaves_like 'API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 5)
    end

    it 'returns countries aggregation' do
      expected_countries = [
        { key: 'Australia', doc_count: 1 },
        { key: 'Canada', doc_count: 2 },
        { key: 'Mexico', doc_count: 2 },
        { key: 'United States', doc_count: 1 }
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
        { key: '/Trade Policy and Agreements', doc_count: 4 },
        { key: '/Trade Policy and Agreements/Trade Agreements', doc_count: 4 },
        { key: '/Trade Policy and Agreements/Trade Agreements/Free Trade Agreements', doc_count: 3 },
        { key: '/Transport and Logistics', doc_count: 1 },
        { key: '/Transport and Logistics/Trade Documents', doc_count: 1 },
        { key: '/Transport and Logistics/Trade Documents/Certificate of Origin', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:topics]).to eq(expected_topics)
    end

    it 'returns trade_regions aggregation' do
      expected_trade_regions = [
        { key: 'Asia Pacific Economic Cooperation', doc_count: 3 },
        { key: 'CAFTA-DR', doc_count: 1 },
        { key: 'Global System of Trade Preferences among Developing Countries', doc_count: 2 },
        { key: 'NAFTA', doc_count: 2 },
        { key: 'Trans Pacific Partnership', doc_count: 3 }
      ]
      expect(parsed_body[:aggregations][:trade_regions]).to eq(expected_trade_regions)
    end

    it 'returns types aggregation' do
      expected_types = [
        { key: 'Article', doc_count: 3 },
        { key: 'Basic Guide To Exporting', doc_count: 1 },
        { key: 'Faq', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:types]).to eq(expected_types)
    end

    it 'returns world_regions aggregation' do
      expected_world_regions = [
        { key: '/Asia Pacific', doc_count: 1 },
        { key: '/Latin America', doc_count: 2 },
        { key: '/North America', doc_count: 2 },
        { key: '/Oceania', doc_count: 1 },
        { key: '/Pacific Rim', doc_count: 3 },
        { key: '/Western Hemisphere', doc_count: 2 }
      ]
      expect(parsed_body[:aggregations][:world_regions]).to eq(expected_world_regions)
    end
  end
end
