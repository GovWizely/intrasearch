require 'rack_helper'

RSpec.describe TaxonomySearch do
  include_context 'shared elastic models',
                  Country,
                  Industry,
                  Topic

  describe '#search_by_labels' do
    context 'when searching for a Country by label' do
      it 'returns matching Country' do
        results = Country.search_by_labels 'CAYMAN  ISLANDS'
        expect(results.first.label).to eq('Cayman Islands')
      end
    end

    context 'when searching for an Industry by label' do
      it 'returns matching Industry' do
        results = Industry.search_by_labels 'SPACE Launch Equipment'
        expect(results.first.label).to eq('Space Launch Equipment')
      end
    end

    context 'when searching for a Topic by label' do
      it 'returns matching Topic' do
        results = Topic.search_by_labels 'BUSINESS MANAGEMENt'
        expect(results.first.label).to eq('Business Management')
      end
    end

    context 'when searching for a Topic with hyphenated label without hyphen' do
      it 'returns matching Topic' do
        results = Topic.search_by_labels 'Anti DumpinG'
        expect(results.first.label).to eq('Anti-Dumping')
      end
    end

    context 'when searching for a Topic with hyphenated label with hyphen' do
      it 'returns matching Topic' do
        results = Topic.search_by_labels 'anti-DumpinG'
        expect(results.first.label).to eq('Anti-Dumping')
      end
    end
  end
end
