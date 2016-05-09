require 'support/api_shared_examples'
require 'support/elastic_model_shared_contexts'

RSpec.describe WebDocumentCountAPI do
  include Rack::Test::Methods

  def app
    Intrasearch::Application
  end

  include_context 'elastic models',
                  WebDocument

  describe '/v1/web_documents/count' do
    before { get '/v1/web_documents/count' }

    subject { last_response }
    let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 4)
    end

    it 'returns domains aggregation' do
      expected_domains = [
        { key: 'bar.example.org', doc_count: 1 },
        { key: 'foo.example.org', doc_count: 3 }
      ]
      expect(parsed_body[:aggregations][:domains]).to eq(expected_domains)
    end
  end
end
