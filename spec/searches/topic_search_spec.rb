require 'rack_helper'

RSpec.describe TopicSearch do
  include_context 'shared elastic models',
                  Topic

  describe '#run' do
    context 'when searching for an exact label' do
      it 'returns matching Topic' do
        label = 'BUSINESS MANAGEMENt'
        results = TopicSearch.new([label]).run
        expect(results.first.label).to eq('Business Management')
      end
    end

    context 'when searching for a hyphenated label without hyphen' do
      it 'returns matching Topic' do
        label = 'Anti DumpinG'
        results = TopicSearch.new([label]).run
        expect(results.first.label).to eq('Anti-Dumping')
      end
    end

    context 'when searching for a hyphenated label with hyphen' do
      it 'returns matching Topic' do
        label = 'anti-DumpinG'
        results = TopicSearch.new([label]).run
        expect(results.first.label).to eq('Anti-Dumping')
      end
    end
  end
end
