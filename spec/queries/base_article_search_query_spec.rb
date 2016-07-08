RSpec.describe BaseArticleSearchQuery do
  describe '#to_hash' do
    context 'when countries is present' do
      it 'filters on countries' do
        expected_query_hash = [
          terms: {
            countries: %w(Mexico Macedonia)
          }
        ]

        query = described_class.new(limit: 10,
                                    offset: 0,
                                    countries: ['Mexico',
                                                ' Macedonia '])
        expect(query.to_hash[:query][:bool][:filter]).to eq(expected_query_hash)
      end
    end

    context 'when trade_regions is present' do
      it 'filters on trade_regions' do
        expected_query_hash = [
          terms: {
            trade_regions: ['European Free Trade Association',
                            'Association of Southeast Asian Nations']
          }
        ]

        query = described_class.new(limit: 10,
                                    offset: 0,
                                    trade_regions: ['European  Free  Trade  Association ',
                                                    ' Association  of  Southeast  Asian  Nations '])
        expect(query.to_hash[:query][:bool][:filter]).to eq(expected_query_hash)
      end
    end

    context 'when world_regions is present' do
      it 'filters on world_regions' do
        expected_query_hash = [
          terms: {
            world_regions: ['North America',
                            'Pacific Rim']
          }
        ]

        query = described_class.new(limit: 10,
                                    offset: 0,
                                    world_regions: [' North  America',
                                                    'Pacific  Rim '])
        expect(query.to_hash[:query][:bool][:filter]).to eq(expected_query_hash)
      end
    end

    context 'when q contains countries' do
      before do
        countries = [
          Country.new(label: 'Congo-Brazzaville'),
          Country.new(label: 'United States')
        ]
        expect(QueryParser).to receive(:parse).
                                 with('healthcare united states Congo Brazzaville').
                                 and_return(non_geo_name_query: 'healthcare',
                                            taxonomies: countries)
      end

      it 'queries on countries' do
        query = described_class.new(limit: 10,
                                    offset: 0,
                                    q: 'healthcare united states Congo Brazzaville')
        expected_query_hash = [
          {
            multi_match: {
              fields: %w(atom title summary),
              operator: 'and',
              query: 'healthcare',
              type: 'cross_fields'
            }
          },
          {
            multi_match: {
              fields: %w(countries^3 atom title summary),
              operator: 'and',
              query: 'Congo-Brazzaville',
              type: 'cross_fields'
            }
          },
          {
            multi_match: {
              fields: %w(countries^3 atom title summary),
              operator: 'and',
              query: 'United States',
              type: 'cross_fields'
            }
          }
        ]
        expect(query.to_hash[:query][:bool][:must]).to eq(expected_query_hash)
      end
    end

    context 'when q contains trade regions' do
      before do
        trade_region = TradeRegion.new(countries: ['Canada',
                                                   'Mexico',
                                                   'United States'],
                                       label: 'NAFTA')
        expect(QueryParser).to receive(:parse).
          with('healthcare nafta').
          and_return(non_geo_name_query: 'healthcare',
                     taxonomies: [trade_region])
      end

      it 'queries on trade regions' do
        query = described_class.new(limit: 10,
                                    offset: 0,
                                    q: 'healthcare nafta')
        expected_query_hash = [
          {
            multi_match: {
              fields: %w(atom title summary),
              operator: 'and',
              query: 'healthcare',
              type: 'cross_fields'
            }
          },
          {
            multi_match: {
              fields: %w(trade_regions^3 atom title summary),
              operator: 'and',
              query: 'NAFTA',
              type: 'cross_fields'
            }
          }
        ]
        expect(query.to_hash[:query][:bool][:must]).to eq(expected_query_hash)
      end
    end

    context 'when q contains world regions' do
      before do
        world_region = WorldRegion.new(countries: ['Canada',
                                                   'Mexico',
                                                   'United States'],
                                       label: 'North America')
        expect(QueryParser).to receive(:parse).
                                 with('healthcare north america').
                                 and_return(non_geo_name_query: 'healthcare',
                                            taxonomies: [world_region])
      end

      it 'queries on world regions' do
        query = described_class.new(limit: 10,
                                    offset: 0,
                                    q: 'healthcare north america')
        expected_query_hash = [
          {
            multi_match: {
              fields: %w(atom title summary),
              operator: 'and',
              query: 'healthcare',
              type: 'cross_fields'
            }
          },
          {
            multi_match: {
              fields: %w(world_regions^3 atom title summary),
              operator: 'and',
              query: 'North America',
              type: 'cross_fields'
            }
          }
        ]
        expect(query.to_hash[:query][:bool][:must]).to eq(expected_query_hash)
      end
    end
  end
end
