require 'support/elastic_model_shared_contexts'

RSpec.describe TradeEventSearchQuery do
  include_context 'elastic models',
                  Country,
                  TradeRegion,
                  WorldRegion,
                  skip_load_yaml: true

  describe '#to_hash' do
    context 'when q is blank' do
      it 'returns sort clause' do
        query = described_class.new(countries: ['United States'], limit: 1, offset: 0)
        expected_sort_clause = [
          {
            start_date: {
              missing: '_first',
              order: 'asc'
            },
            source: { order: 'asc' }
          }
        ]
        expect(query.to_hash[:sort]).to eq(expected_sort_clause)
      end
    end
  end
end
