require 'rack_helper'

RSpec.describe HowToExportArticleSearchAPI do
  include Rack::Test::Methods

  def app
    Intrasearch::Application
  end

  include_context 'shared elastic models',
                  Article,
                  BasicGuideToExporting,
                  Country,
                  Faq,
                  WorldRegion

  describe '/v1/how_to_export_articles/search' do
    let(:endpoint) { '/v1/how_to_export_articles/search' }

    subject { last_response }
    let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

    context 'when searching for articles with matching query term in the title' do
      before { get endpoint, 'q' => 'nafta', 'limit' => 1 }

      it_behaves_like 'API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 3,
                                             count: 1,
                                             offset: 0,
                                             next_offset: 1)
      end

      it 'returns countries aggregation' do
        expected_countries = [
          { key: 'Canada', doc_count: 2 },
          { key: 'Mexico', doc_count: 2 },
          { key: 'United States', doc_count: 1 }
        ]
        expect(parsed_body[:aggregations][:countries]).to eq(expected_countries)
      end

      it 'returns industries aggregation' do
        expect(parsed_body[:aggregations][:industries]).to be_empty
      end

      it 'returns topics aggregation' do
        expected_topics = [
          { key: '/Trade Policy and Agreements', doc_count: 3 },
          { key: '/Trade Policy and Agreements/Trade Agreements', doc_count: 3 },
          { key: '/Trade Policy and Agreements/Trade Agreements/Free Trade Agreements', doc_count: 2 },
          { key: '/Transport and Logistics', doc_count: 1 },
          { key: '/Transport and Logistics/Trade Documents', doc_count: 1 },
          { key: '/Transport and Logistics/Trade Documents/Certificate of Origin', doc_count: 1 }
        ]
        expect(parsed_body[:aggregations][:topics]).to eq(expected_topics)
      end

      it 'returns trade_regions aggregation' do
        expected_trade_regions = [
          { key: 'Asia Pacific Economic Cooperation', doc_count: 2 },
          { key: 'CAFTA-DR', doc_count: 1 },
          { key: 'Global System of Trade Preferences among Developing Countries', doc_count: 2 },
          { key: 'NAFTA', doc_count: 2 },
          { key: 'Trans Pacific Partnership', doc_count: 2 }
        ]
        expect(parsed_body[:aggregations][:trade_regions]).to eq(expected_trade_regions)
      end

      it 'returns types aggregation' do
        expected_types = [
          { key: 'Article', doc_count: 1 },
          { key: 'Basic Guide To Exporting', doc_count: 1 },
          { key: 'Faq', doc_count: 1 }
        ]
        expect(parsed_body[:aggregations][:types]).to eq(expected_types)
      end

      it 'returns world_regions aggregation' do
        expected_world_regions = [
          { key: '/Latin America', doc_count: 2 },
          { key: '/North America', doc_count: 2 },
          { key: '/Pacific Rim', doc_count: 2 },
          { key: '/Western Hemisphere', doc_count: 2 }
        ]
        expect(parsed_body[:aggregations][:world_regions]).to eq(expected_world_regions)
      end

      it 'highlights matching terms in the title' do
        expect(parsed_body[:results].count).to eq(1)

        expected_first_result = {
          id: 'ka8t0000000GnHmAAK',
          snippet: 'General Information The North American Free Trade Agreement (<em>NAFTA</em>), which was enacted in 1994 and created a free trade zone for Mexico, Canada, and the United States, is the most important feature in the U.S.-Mexico bilateral commercial relationship ...',
          title: '<em>NAFTA</em>',
          url: 'https://example.org/article2?id=North-American-Free-Trade-Agreement' }
        expect(parsed_body[:results].first).to eq(expected_first_result)
      end
    end

    context 'when searching for articles with matching query term in the summary' do
      before { get endpoint, 'q' => 'overview', 'limit' => 1 }

      it_behaves_like 'API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 1,
                                             count: 1,
                                             offset: 0,
                                             next_offset: nil)
      end

      it 'renders truncated atom in the snippet' do
        expect(parsed_body[:results].count).to eq(1)

        expected_first_result = {
          id: 'ka8t0000000GnHmAAK',
          snippet: 'General Information The North American Free Trade Agreement (NAFTA), which was enacted in 1994 and created a free trade zone for Mexico, Canada, and the United States, is the most important feature in the U.S.-Mexico bilateral commercial relationship. As ...',
          title: 'NAFTA',
          url: 'https://example.org/article2?id=North-American-Free-Trade-Agreement' }
        expect(parsed_body[:results].first).to eq(expected_first_result)
      end
    end

    context 'when searching for articles with matching query term in the atom' do
      before { get endpoint, 'q' => 'trademark', 'limit' => 1 }

      it_behaves_like 'API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 1,
                                             count: 1,
                                             offset: 0,
                                             next_offset: nil)
      end

      it 'highlights matching terms from the atom' do
        expect(parsed_body[:results].count).to eq(1)

        expected_first_result = {
          id: 'ka8t0000000GnHmAAK',
          snippet: '...  with the exception of aviation transport, maritime, and basic telecommunications. The agreement also provides intellectual property rights protection in a variety of areas including patent, <em>trademark</em>, and copyrighted material. The government procurement provisions ...',
          title: 'NAFTA',
          url: 'https://example.org/article2?id=North-American-Free-Trade-Agreement' }
        expect(parsed_body[:results].first).to eq(expected_first_result)
      end
    end

    context 'when searching for articles with countries' do
      before { get endpoint, countries: ' canadA, bogus country, czech republiC' }

      it_behaves_like 'API response'

      it 'returns matching countries aggregation' do
        expected_countries = [
          { key: 'Canada', doc_count: 2 },
          { key: 'Mexico', doc_count: 2 },
          { key: 'United States', doc_count: 1 }
        ]
        expect(parsed_body[:aggregations][:countries]).to eq(expected_countries)
      end
    end

    context 'when searching for articles with industries' do
      before { get endpoint, industries: 'eCommerce Industry, spacE ' }

      it_behaves_like 'API response'

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

    context 'when searching for articles with topics' do
      before { get endpoint, topics: 'Free TradE AgreementS , invalid ' }

      it_behaves_like 'API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 3,
                                             count: 3,
                                             offset: 0,
                                             next_offset: nil)
      end

      it 'returns matching topics aggregation' do
        expected_topics = [
          { key: '/Trade Policy and Agreements', doc_count: 3 },
          { key: '/Trade Policy and Agreements/Trade Agreements', doc_count: 3 },
          { key: '/Trade Policy and Agreements/Trade Agreements/Free Trade Agreements', doc_count: 3 },
          { key: '/Transport and Logistics', doc_count: 1 },
          { key: '/Transport and Logistics/Trade Documents', doc_count: 1 },
          { key: '/Transport and Logistics/Trade Documents/Certificate of Origin', doc_count: 1 }
        ]
        expect(parsed_body[:aggregations][:topics]).to eq(expected_topics)
      end
    end

    context 'when searching for articles with trade regions' do
      before { get endpoint, trade_regions: ' invalid  , Trans Pacific PartnershiP, Asia Pacific Economic CooperatioN ' }

      it_behaves_like 'API response'

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
    end

    context 'when searching for articles with world regions' do
      before { get endpoint, world_regions: ' invalid  , pacific RIM  , westerN Hemisphere ' }

      it_behaves_like 'API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 3,
                                             count: 3,
                                             offset: 0,
                                             next_offset: nil)
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

    context 'when searching for articles with limit and offset' do
      before { get endpoint, limit: 1, offset: 1, q: 'nafta' }

      it_behaves_like 'API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 3,
                                             count: 1,
                                             offset: 1,
                                             next_offset: 2)
      end
    end

    context 'when searching for articles where not all query terms are present in the index' do
      before { get endpoint, q: 'atom nafta' }

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

    context 'when query contains geo names' do
      before { get endpoint, q: 'north america' }

      it_behaves_like 'API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 2,
                                             count: 2,
                                             offset: 0,
                                             next_offset: nil)
      end
    end

    context 'when query contains HTML entity name' do
      before { get endpoint, q: 'amp' }

      it_behaves_like 'API response'

      it 'returns empty results' do
        expect(parsed_body[:results]).to be_empty
      end
    end
  end
end
