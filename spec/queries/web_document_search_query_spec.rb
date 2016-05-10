RSpec.describe WebDocumentSearchQuery do
  describe '#to_hash' do
    context 'when include_aggregations is false' do
      it 'returns query with aggregations' do
        query = described_class.new domains: 'example.org',
                                    include_aggregations: false,
                                    limit: 1,
                                    offset: 0
        expect(query.to_hash).not_to include(:aggs)
      end
    end
  end
end
