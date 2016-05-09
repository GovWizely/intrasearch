RSpec.describe TradeRegionImporter do
  describe '#import' do
    let(:resource) { Intrasearch.root.join('spec/fixtures/owl/regions.owl') }

    let(:expected_args) do
      [
        { countries: ['Bolivia', 'Colombia'],
          id: 'http://webprotege.stanford.edu/RB53lPnm186ivFLEXmbWylT',
          label: 'Andean Community',
          path: '/Andean Community' },
        { countries: ['China', 'Japan'],
          id: 'http://webprotege.stanford.edu/R7YQAlNP4iXuBJLBhgPAcIO',
          label: 'Asia Pacific Economic Cooperation',
          path: '/Asia Pacific Economic Cooperation' },
        { countries: ['Netherlands'],
          id: 'http://webprotege.stanford.edu/RFHDdg8ngDrQ1rheh59xdL',
          label: 'European Union - 28',
          path: '/European Union - 28' },
        { countries: ['Algeria', 'Angola'],
          id: 'http://webprotege.stanford.edu/RColoqFfo8G4Klm60b7QkwU',
          label: 'Organization of the Petroleum Exporting Countries',
          path: '/Organization of the Petroleum Exporting Countries' }
      ]
    end

    it 'creates Trade Region' do
      expected_args.each do |arg_hash|
        expect(TradeRegion).to receive(:create).with(arg_hash)
      end
      described_class.import resource
    end
  end
end
