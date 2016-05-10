RSpec.describe WebDocumentExtractor do
  describe '.extractor' do
    let(:domain) { 'foo.example.org' }
    let(:response) do
      body = Intrasearch.root.join('spec/fixtures/json/web_documents.json').read
      instance_double Faraday::Response,
                      body: body
    end

    before do
      client = instance_double Restforce::Data::Client
      expect(Restforce).to receive(:new).and_return(client)
      expect(client).to receive(:get).
                          with('/services/apexrest/content?site=foo.example.org&since=0').
                          and_return(response)
    end

    it 'returns an enumerator' do
      expected_args = {
        title: 'Welcome Page',
        url: '/welcome',
        description: 'description of this document',
        content: 'Welcome to the document content'
      }

      results = described_class.extract domain
      expect { |block| results.each(&block) }.to yield_successive_args(expected_args)
    end
  end
end
