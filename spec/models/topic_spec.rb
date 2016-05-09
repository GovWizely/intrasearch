require 'support/elastic_model_shared_contexts'

RSpec.describe Topic do
  include_context 'elastic models',
                  Topic

  describe '.search_by_labels' do
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
