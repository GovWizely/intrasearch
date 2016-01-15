require 'rack_helper'

RSpec.describe ArticleSearchQuery do
  describe '#to_hash' do
    context 'when countries is present' do
      it 'filters on countries' do
        expected_query_hash = [
          terms: {
            countries: ['mexico',
                        'macedonia']
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
  end
end
