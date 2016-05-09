RSpec.describe WorldRegionImporter do
  describe '#import' do
    let(:resource) { Intrasearch.root.join('spec/fixtures/owl/regions.owl') }

    let(:expected_args) do
      [
        { countries: ['Afghanistan', 'China', 'Hong Kong', 'Japan', 'Kazakhstan'],
          id: 'http://webprotege.stanford.edu/R91fGuW6GPOnb7XSylIPwR5',
          label: 'Asia',
          path: '/Asia' },
        { countries: ['Afghanistan', 'Kazakhstan'],
          id: 'http://webprotege.stanford.edu/R9pQ9NO7LyXj7vL7WbTAVVA',
          label: 'Central Asia',
          path: '/Asia/Central Asia' },
        { countries: ['China', 'Hong Kong', 'Japan'],
          id: 'http://webprotege.stanford.edu/RDAklO0LFVtjIoIUYj4Dg4M',
          label: 'East Asia',
          path: '/Asia/East Asia' },
        { countries: ['Belize', 'Costa Rica', 'El Salvador'],
          id: 'http://webprotege.stanford.edu/RSdD0vStFEjovpmpaEuydN',
          label: 'Central America',
          path: '/Central America' }
      ]
    end

    it 'creates World Region' do
      expected_args.each do |arg_hash|
        expect(WorldRegion).to receive(:create).with(arg_hash)
      end
      described_class.import resource
    end
  end
end
