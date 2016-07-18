RSpec.describe WebDocumentImporter do
  describe '.import' do
    before do
      extracted_args = [
        {
          content: 'Welcome to the document content',
          description: 'description of this document',
          title: 'Welcome Page',
          url: '/welcome'
        }
      ]
      expect(WebDocumentExtractor).to receive(:extract).and_return(extracted_args.to_enum)
    end

    it 'imports WebDocument' do
      described_class.import
      document = WebDocument.all.first

      expected_attributes = {
        content: 'Welcome to the document content',
        description: 'description of this document',
        domain: 'foo.example.org',
        title: 'Welcome Page',
        url: 'https://foo.example.org/welcome'
      }
      expect(document).to have_attributes(expected_attributes)
    end
  end
end
