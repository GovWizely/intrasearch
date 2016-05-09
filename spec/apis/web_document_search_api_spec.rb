require 'support/api_shared_examples'
require 'support/elastic_model_shared_contexts'

RSpec.describe WebDocumentSearchAPI do
  include Rack::Test::Methods

  def app
    Intrasearch::Application
  end

  include_context 'elastic models',
                  WebDocument

  describe '/v1/web_documents/search' do
    let(:endpoint) { '/v1/web_documents/search' }

    subject { last_response }
    let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }

    context 'when searching for web documents with matching query term in the title' do
      before { get endpoint, 'domains' => 'foo.example.org', 'q' => 'foo home title' }

      it_behaves_like 'a successful API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 1,
                                             count: 1,
                                             offset: 0,
                                             next_offset: nil)
      end

      it 'renders highlighted title' do
        expect(parsed_body[:results].count).to eq(1)

        expected_result = {
          title: '<em>Foo</em> <em>Home</em> page <em>title</em>',
          url: 'https://foo.example.org/home',
          snippet: '<em>Home</em> page content.'
        }
        expect(parsed_body[:results].first).to eq(expected_result)
      end
    end

    context 'when searching for web documents with matching query term in the description' do
      before { get endpoint, 'domains' => 'foo.example.org', 'q' => 'lorem ipsum description' }

      it_behaves_like 'a successful API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 1,
                                             count: 1,
                                             offset: 0,
                                             next_offset: nil)
      end

      it 'renders truncated content' do
        expected_result = {
          title: 'Welcome',
          url: 'https://foo.example.org/welcome',
          snippet: 'Welcome to the United States Success in the U.S. market can help drive success globally. With an annual GDP of $18 trillion and population of over 320 million, the United States is the world’s most attractive consumer market, offering unmatched ...'
        }
        expect(parsed_body[:results].first).to eq(expected_result)
      end
    end

    context 'when searching for web documents with matching query term in the content' do
      before { get endpoint, 'domains' => 'foo.example.org', 'q' => 'success' }

      it_behaves_like 'a successful API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 1,
                                             count: 1,
                                             offset: 0,
                                             next_offset: nil)
      end

      it 'renders highlighted content' do
        expected_result = {
          title: 'Welcome',
          url: 'https://foo.example.org/welcome',
          snippet: 'Welcome to the United States <em>Success</em> in the U.S. market can help drive <em>success</em> globally. With an annual GDP of $18 trillion and population of over 320 million, the United States is the world’s most attractive consumer market, offering unmatched diversity ...'
        }
        expect(parsed_body[:results].first).to eq(expected_result)
      end
    end

    context 'when searching for web documents with limit and offset' do
      before { get endpoint, 'domains' => 'foo.example.org', 'q' => 'description', 'limit' => '1', 'offset' => '1' }

      it_behaves_like 'a successful API response'

      it 'returns metadata' do
        expect(parsed_body[:metadata]).to eq(total: 3,
                                             count: 1,
                                             offset: 1,
                                             next_offset: 2)
      end
    end
  end
end
