require 'rack_helper'

RSpec.describe TradeRegionImporter do
  describe '#import' do
    let(:subject) do
      described_class.new Nix.root.join('spec/fixtures/owls/regions.owl.xml')
    end

    let(:expected_args) do
      [{ countries: ['Bolivia', 'Colombia'],
         id: 'http://webprotege.stanford.edu/RB53lPnm186ivFLEXmbWylT',
         label: 'Andean Community',
         path: '/Andean Community' },
       { countries: ['Algeria', 'Angola'],
         id: 'http://webprotege.stanford.edu/RColoqFfo8G4Klm60b7QkwU',
         label: 'Organization of the Petroleum Exporting Countries',
         path: '/Organization of the Petroleum Exporting Countries' }]
    end

    it 'creates Trade Region' do
      expected_args.each do |arg_hash|
        expect(TradeRegion).to receive(:create).with(arg_hash)
      end
      subject.import
    end
  end
end
