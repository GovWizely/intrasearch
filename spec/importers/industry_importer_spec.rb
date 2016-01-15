require 'rack_helper'

RSpec.describe IndustryImporter do
  describe '#import' do
    let(:resource) { Nix.root.join('spec/fixtures/owls/industries.owl.xml') }

    let(:expected_args) do
      [{ label: 'Aerospace and Defense',
         path: '/Aerospace and Defense' },
       { label: 'Space',
         path: '/Aerospace and Defense/Space' },
       { label: 'Space Launch Equipment',
         path: '/Aerospace and Defense/Space/Space Launch Equipment' },
       { label: 'Satellites',
         path: '/Aerospace and Defense/Space/Satellites' },
       { label: 'Defense Equipment',
         path: '/Aerospace and Defense/Defense Equipment' }]
    end

    it 'creates Industry' do
      expected_args.each do |industry_hash|
        expect(Industry).to receive(:create).with(industry_hash)
      end
      described_class.import resource
    end
  end
end
