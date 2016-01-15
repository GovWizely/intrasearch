require 'rack_helper'

RSpec.describe WorldRegionImporter do
  describe '#import' do
    let(:resource) { Nix.root.join('spec/fixtures/owls/regions.owl.xml') }

    let(:expected_args) do
      [{ countries: ['Belize', 'Costa Rica', 'El Salvador'],
         id: 'http://webprotege.stanford.edu/RSdD0vStFEjovpmpaEuydN',
         label: 'Central America',
         path: '/Central America' },
       { countries: ['China', 'Hong Kong', 'Japan'],
         id: 'http://webprotege.stanford.edu/RDAklO0LFVtjIoIUYj4Dg4M',
         label: 'East Asia',
         path: '/East Asia' }]
    end

    it 'creates World Region' do
      expected_args.each do |arg_hash|
        expect(WorldRegion).to receive(:create).with(arg_hash)
      end
      described_class.import resource
    end
  end
end
