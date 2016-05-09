require 'support/elastic_model_shared_contexts'

RSpec.describe Country do
  include_context 'elastic models',
                  Country

  describe '.search_by_labels' do
    context 'when searching for a Country by label' do
      it 'returns matching Country' do
        results = Country.search_by_labels 'CAYMAN  ISLANDS'
        expect(results.first.label).to eq('Cayman Islands')
      end
    end
  end
end
