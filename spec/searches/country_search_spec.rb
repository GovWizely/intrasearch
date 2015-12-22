require 'rack_helper'

RSpec.describe CountrySearch do
  include_context 'shared elastic models',
                  Country

  describe '#run' do
    let(:expected_leaf_node_label) { 'Cayman Islands' }

    context 'when searching for an exact label' do
      it 'returns matching Country' do
        label = 'CAYMAN  ISLANDS'
        results = CountrySearch.new([label]).run
        expect(results.first.label).to eq(expected_leaf_node_label)
      end
    end

    context 'when labels are not present' do
      it 'returns an empty array' do
        expect(CountrySearch.new(nil).run).to be_empty
      end
    end
  end
end
