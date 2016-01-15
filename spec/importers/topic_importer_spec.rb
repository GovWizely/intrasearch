require 'rack_helper'

RSpec.describe TopicImporter do
  describe '#import' do
    let(:resource) { Nix.root.join('spec/fixtures/owls/topics.owl.xml') }

    let(:expected_args) do
      [{ label: 'Business Management',
         path: '/Business Management' },
       { label: 'Advertising',
         path: '/Business Management/Advertising' },
       { label: 'Costing and Pricing',
         path: '/Business Management/Costing and Pricing' },
       { label: 'Prices',
         path: '/Business Management/Costing and Pricing/Prices' }]
    end

    it 'creates Topic' do
      expected_args.each do |topic_hash|
        expect(Topic).to receive(:create).with(topic_hash)
      end
      described_class.import resource
    end
  end
end
