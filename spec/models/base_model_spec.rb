RSpec.describe BaseModel do
  describe '.model_classes' do
    it 'returns only classes' do
      expect(described_class.model_classes).to include(Country,
                                                       CountryCommercialGuide,
                                                       TradeEvent::DlTradeEvent)
      expect(described_class.model_classes).not_to include(BaseArticle,
                                                           Taxonomy,
                                                           TradeEvent::BaseModel)
    end
  end
end
