require 'rack_helper'

RSpec.describe TopicImporter do
  describe '#import' do
    let(:subject) do
      described_class.new Nix.root.join('spec/fixtures/owls/topics.owl.xml')
    end

    let(:expected_args) do
      [{ id: 'topic-R91Dng1U47EaYAk2N8v1S3K',
         label: 'Business Management',
         leaf_node: false,
         path: '/Business Management' },
       { id: 'topic-R9YOsvzIE1KryZEJIc96KLh',
         label: 'Advertising',
         leaf_node: true,
         path: '/Business Management/Advertising' },
       { id: 'topic-RBiSXpV761vpfWqujxnp0zH',
         label: 'Costing and Pricing',
         leaf_node: false,
         path: '/Business Management/Costing and Pricing' },
       { id: 'topic-RB5r4mTSRmptLtIzUtghLOS',
         label: 'Prices',
         leaf_node: true,
         path: '/Business Management/Costing and Pricing/Prices' }]
    end

    it 'creates Topic' do
      expected_args.each do |topic_hash|
        expect(Topic).to receive(:create).with(topic_hash)
      end
      subject.import
    end
  end
end
