require 'support/elastic_model_shared_contexts'

RSpec.describe CountryImporter do
  include_context 'elastic models',
                  TradeRegion,
                  WorldRegion

  describe '#import' do
    let(:resource) { Intrasearch.root.join('spec/fixtures/owl/regions.owl') }

    let(:expected_args) do
      [
        { id: 'http://webprotege.stanford.edu/RDzjXT0GYF9ecQbq6oyxewD',
          label: 'Afghanistan',
          path: '/Afghanistan',
          trade_regions: [],
          world_region_paths: [],
          world_regions: [] },
        { id: 'http://webprotege.stanford.edu/RUXeWvtXzfnZOcThs5oRWn',
          label: 'Algeria',
          path: '/Algeria',
          trade_regions: ['Organization of the Petroleum Exporting Countries'],
          world_region_paths: [],
          world_regions: [] },
        { id: 'http://webprotege.stanford.edu/RDGdyJ5jz8VooldQaO7rzOa',
          label: 'Angola',
          path: '/Angola',
          trade_regions: ['Organization of the Petroleum Exporting Countries'],
          world_region_paths: [],
          world_regions: [] },
        { id: 'http://webprotege.stanford.edu/RDXjKihUhEKJOVRkiX3V0xz',
          label: 'Aruba',
          path: '/Aruba',
          trade_regions: [],
          world_region_paths: [],
          world_regions: [] },
        { id: 'http://webprotege.stanford.edu/RDjGw17VBjBm1pfdtbcTiu7',
          label: 'Belize',
          path: '/Belize',
          trade_regions: [],
          world_region_paths: ['/Central America'],
          world_regions: ['Central America'] },
        { id: 'http://webprotege.stanford.edu/RCHnGGZ8oROz1NPBYEs8ldE',
          label: 'Bolivia',
          path: '/Bolivia',
          trade_regions: ['Andean Community'],
          world_region_paths: [],
          world_regions: [] },
        { id: 'http://webprotege.stanford.edu/RCFeONxXFzHO4GMg16HylOc',
          label: 'China',
          path: '/China',
          trade_regions: ['Asia Pacific Economic Cooperation'],
          world_region_paths: ['/Asia/East Asia'],
          world_regions: ['Asia', 'East Asia'] },
        { id: 'http://webprotege.stanford.edu/R83RBxX91o3z1pt0cXjXvgN',
          label: 'Colombia',
          path: '/Colombia',
          trade_regions: ['Andean Community'],
          world_region_paths: [],
          world_regions: [] },
        { id: 'http://webprotege.stanford.edu/RcoC6hxvjY1WRMKV6cW3US',
          label: 'Costa Rica',
          path: '/Costa Rica',
          trade_regions: [],
          world_region_paths: ['/Central America'],
          world_regions: ['Central America'] },
        { id: 'http://webprotege.stanford.edu/RC88gcQj9C5qKRAgVRLOUBn',
          label: 'El Salvador',
          path: '/El Salvador',
          trade_regions: [],
          world_region_paths: ['/Central America'],
          world_regions: ['Central America'] },
        { id: 'http://webprotege.stanford.edu/ReBrW4erCA9bTkbUVAjWbG',
          label: 'Hong Kong',
          path: '/Hong Kong',
          trade_regions: [],
          world_region_paths: ['/Asia/East Asia'],
          world_regions: ['Asia', 'East Asia'] },
        { id: 'http://webprotege.stanford.edu/RDfDY0ur68lqxEDkatxoedV',
          label: 'Japan',
          path: '/Japan',
          trade_regions: ['Asia Pacific Economic Cooperation'],
          world_region_paths: ['/Asia/East Asia'],
          world_regions: ['Asia', 'East Asia'] },
        { id: 'http://webprotege.stanford.edu/RBw8ndgL3iXtxxTP560v6yZ',
          label: 'Kazakhstan',
          path: '/Kazakhstan',
          trade_regions: [],
          world_region_paths: [],
          world_regions: [] },
        { id: 'http://webprotege.stanford.edu/R7tAfn5WOKgOPGoU8fXB1ba',
          label: 'Netherlands',
          path: '/Netherlands',
          trade_regions: [],
          world_region_paths: [],
          world_regions: []
        }
      ]
    end

    it 'creates Country' do
      expected_args.each do |industry_hash|
        expect(Country).to receive(:create).with(industry_hash)
      end
      described_class.import resource
    end
  end
end
