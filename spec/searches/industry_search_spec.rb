require 'rack_helper'

RSpec.describe IndustrySearch do
  include_context 'shared elastic models',
                  Industry
  # before(:all) do
  #   IndexManager.new(Industry).setup_new_index! do
  #     industries = YAML.load Nix.root.join('spec/fixtures/yaml/industries.yml').read
  #     industries.each do |industry_hash|
  #       Industry.create industry_hash
  #     end
  #   end
  # end
  #
  # after(:all) do
  #   Industry.gateway.delete_index!
  # end

  describe '#run' do
    let(:expected_leaf_node_label) { 'Space Launch Equipment' }

    context 'when searching for an exact label' do
      it 'returns matching Industry' do
        label = 'Space Launch Equipment'
        results = IndustrySearch.new([label]).run
        expect(results.first.label).to eq(expected_leaf_node_label)
      end
    end

    context 'when searching for a label with case mismatch and spaces' do
      it 'returns matching Industry' do
        label = '  Space lAUNCh  Equipment '
        results = IndustrySearch.new([label]).run

        expect(results.total).to eq(1)
        expect(results.first.label).to eq(expected_leaf_node_label)
      end
    end

    context 'when filtering by leaf_node=false' do
      it 'returns matching Industry' do
        label = 'Aerospace and Defense'
        results = IndustrySearch.new([label], false).run

        expect(results.total).to eq(1)
        expect(results.first.label).to eq(label)
      end
    end

    context 'when filtering by leaf_node=true for an existing Industry' do
      it 'returns matching Industry' do
        label = 'Space Launch Equipment'
        results = IndustrySearch.new([label], true).run

        expect(results.total).to eq(1)
        expect(results.first.label).to eq(expected_leaf_node_label)
      end
    end

    context 'when filtering by leaf_node=false for an invalid Industry' do
      it 'returns no results' do
        label = 'Space Launch Equipment'
        results = IndustrySearch.new([label], false).run
        expect(results.count).to eq(0)
      end
    end
  end
end
