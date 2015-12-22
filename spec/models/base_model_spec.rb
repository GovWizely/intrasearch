require 'rack_helper'

RSpec.describe BaseModel do
  describe '.model_classes' do
    it 'returns only classes' do
      expect(described_class.model_classes).to include(Country, CountryCommercialGuide)
      expect(described_class.model_classes).not_to include(Article, Taxonomy)
    end
  end
end
