RSpec.describe TradeRegionExtractor do
  describe '.extract' do
    let(:resource) { Intrasearch.root.join('spec/fixtures/owl/regions.owl') }

    it 'parses only immediate skos:related countries' do
      trade_regions = TradeRegionExtractor.extract(resource)

      eu_region = trade_regions.find { |tr| tr[:label] == 'European Union - 28'}
      grand_child_country = 'Aruba'

      expect(eu_region[:countries]).not_to include(grand_child_country)
    end
  end
end
