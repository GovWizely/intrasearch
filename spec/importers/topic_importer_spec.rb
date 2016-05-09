RSpec.describe TopicImporter do
  describe '#import' do
    let(:resource) { Intrasearch.root.join('spec/fixtures/owl/topics.owl') }

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
