require 'rack_helper'

RSpec.describe CountryImporter do
  include_context 'shared elastic models',
                  TradeRegion

  describe '#import' do
    let(:subject) do
      described_class.new Nix.root.join('spec/fixtures/owls/regions.owl.xml')
    end

    let(:expected_args) do
      [{ id: 'http://webprotege.stanford.edu/RUXeWvtXzfnZOcThs5oRWn',
         label: 'Algeria',
         path: '/Algeria',
         trade_regions: ['Organization of the Petroleum Exporting Countries'] },
       { id: 'http://webprotege.stanford.edu/RDGdyJ5jz8VooldQaO7rzOa',
         label: 'Angola',
         path: '/Angola',
         trade_regions: ['Organization of the Petroleum Exporting Countries'] },
       { id: 'http://webprotege.stanford.edu/RCHnGGZ8oROz1NPBYEs8ldE',
         label: 'Bolivia',
         path: '/Bolivia',
         trade_regions: ['Andean Community'] },
       { id: 'http://webprotege.stanford.edu/R83RBxX91o3z1pt0cXjXvgN',
         label: 'Colombia',
         path: '/Colombia',
         trade_regions: ['Andean Community'] }]
    end

    it 'creates Country' do
      expected_args.each do |industry_hash|
        expect(Country).to receive(:create).with(industry_hash)
      end
      subject.import
    end
  end
end
