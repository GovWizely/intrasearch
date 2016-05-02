require 'rack_helper'

RSpec.describe BaseArticleSearchQuery do
  describe '#to_hash' do
    context 'when countries is present' do
      it 'filters on countries' do
        expected_query_hash = [
          terms: {
            countries: %w(mexico macedonia)
          }
        ]

        query = described_class.new(limit: 10,
                                    offset: 0,
                                    countries: ['Mexico',
                                                ' MacedoniA '])
        expect(query.to_hash[:query][:filtered][:query][:bool][:must]).to eq(expected_query_hash)
      end
    end

    context 'when trade_regions is present' do
      it 'filters on trade_regions' do
        expected_query_hash = [
          terms: {
            trade_regions: ['european free trade association',
                            'association of southeast asian nations']
          }
        ]

        query = described_class.new(limit: 10,
                                    offset: 0,
                                    trade_regions: ['European Free Trade Association',
                                                    'Association of Southeast Asian NationS'])
        expect(query.to_hash[:query][:filtered][:query][:bool][:must]).to eq(expected_query_hash)
      end
    end

    context 'when world_regions is present' do
      it 'filters on world_regions' do
        expected_query_hash = [
          terms: {
            world_regions: ['north america',
                            'pacific rim']
          }
        ]

        query = described_class.new(limit: 10,
                                    offset: 0,
                                    world_regions: [' North  americA',
                                                    'pacifiC riM '])
        expect(query.to_hash[:query][:filtered][:query][:bool][:must]).to eq(expected_query_hash)
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
        expected_query_hash = {
          bool: {
            must: [
              {
                multi_match: {
                  fields: %w(atom title summary),
                  operator: 'and',
                  query: 'healthcare'
                }
              },
              {
                multi_match: {
                  fields: %w(atom countries^3 title summary),
                  operator: 'and',
                  query: 'Congo-Brazzaville',
                }
              },
              {
                multi_match: {
                  fields: %w(atom countries^3 title summary),
                  operator: 'and',
                  query: 'United States',
                }
              }
            ]
          }
        }
        expect(query.to_hash[:query][:filtered][:query]).to eq(expected_query_hash)
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
        expected_query_hash = {
          bool: {
            must: [
              {
                multi_match: {
                  fields: %w(atom title summary),
                  operator: 'and',
                  query: 'healthcare'
                }
              },
              {
                multi_match: {
                  fields: %w(atom title summary world_regions^3),
                  operator: 'and',
                  query: 'North America',
                }
              }
            ]
          }
        }
        expect(query.to_hash[:query][:filtered][:query]).to eq(expected_query_hash)
      end
    end
  end
end
