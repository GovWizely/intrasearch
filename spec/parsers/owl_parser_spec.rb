require 'rack_helper'

RSpec.describe OwlParser do
  let(:file) do
    File.open(Nix.root.join('spec/fixtures/owls/root.owl.xml'))
  end

  subject { described_class.new file: file, id_prefix: 'aero', root_label: 'Aerospace and Defense' }

  let(:expected_args) do
    [{ id: 'aero-R3anJjpDBXy092dEyJ0nXU',
       label: 'Space',
       leaf_node: false,
       path: '/Space' },
     { id: 'aero-RBDqmXn5UkwLCF1ECytDdEW',
       label: 'Space Launch Equipment',
       leaf_node: true,
       path: '/Space/Space Launch Equipment' },
     { id: 'aero-RYbXL8shWgdXfnSIFLoUZI',
       label: 'Satellites',
       leaf_node: true,
       path: '/Space/Satellites' },
     { id: 'aero-R9lHhOo010EPhoajnKC2Lvg',
       label: 'Defense Equipment',
       leaf_node: true,
       path: '/Defense Equipment' }]
  end

  describe '#each_class' do
    context 'when max_depth is not set' do
      subject { described_class.new file: file, id_prefix: 'aero', root_label: 'Aerospace and Defense' }

      it 'yields node hash' do
        expect { |block| subject.each_class(&block) }.to yield_successive_args(*expected_args)
      end

    end


    context 'when max_depth is set' do
      subject do
        described_class.new file: file,
                            id_prefix: 'aero',
                            max_depth: 1,
                            root_label: 'Aerospace and Defense'
      end

      it 'yields node hash' do
        expect { |block| subject.each_class(&block) }.to yield_successive_args(expected_args.first, expected_args.last)
      end
    end
  end

end
