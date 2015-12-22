require 'rack_helper'

RSpec.describe IndustryImporter do
  describe '#import' do
    let(:subject) do
      described_class.new(resource: Nix.root.join('spec/fixtures/owls/root.owl.xml'),
                          taxonomy_root_label: 'Aerospace and Defense')
    end

    let(:expected_args) do
      [{ id: 'industry-R3anJjpDBXy092dEyJ0nXU',
         label: 'Space',
         leaf_node: false,
         path: '/Space' },
       { id: 'industry-RBDqmXn5UkwLCF1ECytDdEW',
         label: 'Space Launch Equipment',
         leaf_node: true,
         path: '/Space/Space Launch Equipment' },
       { id: 'industry-RYbXL8shWgdXfnSIFLoUZI',
         label: 'Satellites',
         leaf_node: true,
         path: '/Space/Satellites' },
       { id: 'industry-R9lHhOo010EPhoajnKC2Lvg',
         label: 'Defense Equipment',
         leaf_node: true,
         path: '/Defense Equipment' }]
    end

    it 'creates Industry' do
      expected_args.each do |industry_hash|
        expect(Industry).to receive(:create).with(industry_hash)
      end
      subject.import
    end
  end
end
