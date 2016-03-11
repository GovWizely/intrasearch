require 'rack_helper'

RSpec.describe Industry do
  include_context 'shared elastic models',
                  Industry

  describe '.search_by_labels' do
    context 'when searching for an Industry by label' do
      it 'returns matching Industry' do
        results = Industry.search_by_labels 'SPACE Launch Equipment'
        expect(results.first.label).to eq('Space Launch Equipment')
      end
    end
  end
end
