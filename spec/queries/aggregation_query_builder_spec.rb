require 'rack_helper'

RSpec.describe AggregationQueryBuilder do
  describe '#build' do
    context 'when terms parameter is empty' do
      it 'returns unfiltered aggregation' do
        expected_hash = {
          countries: {
            terms: {
              field: 'countries.raw',
              order: { _term: 'asc' },
              size: 0
            }
          }
        }
        expect(described_class.new.build(:countries,
                                         field: 'countries.raw')).to eq(expected_hash)
      end
    end

    context 'when terms parameter is present' do
      it 'returns unfiltered aggregation' do
        expected_hash = {
          countries: {
            terms: {
              field: 'countries.raw',
              include: {
                pattern: 'foo|bar',
                flags: 'CASE_INSENSITIVE'
              },
              order: { _term: 'asc' },
              size: 0
            }
          }
        }
        expect(described_class.new.build(:countries,
                                         field: 'countries.raw',
                                         terms: %w(foo bar))).to eq(expected_hash)
      end
    end

    context 'when use_path_wildcard is true' do
      it 'returns unfiltered aggregation' do
        expected_hash = {
          industries: {
            terms: {
              field: 'industry_paths',
              include: {
                pattern: '.*(/Foo|/Bar)(/?.*)',
                flags: 'CASE_INSENSITIVE'
              },
              order: { _term: 'asc' },
              size: 0
            }
          }
        }
        expect(described_class.new.build(:industries,
                                         field: 'industry_paths',
                                         terms: %w(/Foo /Bar),
                                         use_path_wildcard: true)).to eq(expected_hash)
      end
    end
  end
end
