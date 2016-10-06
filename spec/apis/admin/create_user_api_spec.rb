require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe Admin::UpdateUserAPI, endpoint: '/admin/users' do
  include APISpecHelpers

  include_context 'elastic models',
                  User

  include_context 'API response'

  context 'when the request contains valid parameters' do
    let(:request_body_hash) {
      {
        email: 'new@example.org'
      }
    }

    before { send_json :post, described_endpoint, request_body_hash }

    it 'creates a User' do
      expect(last_response.status).to eq(201)

      user = User.find parsed_body[:id]
      expect(user).to have_attributes(request_body_hash)
    end
  end

  context 'when the request parameter is missing' do
    let(:request_body_hash) { {} }

    before { send_json :post, described_endpoint, request_body_hash }

    it_behaves_like 'a bad request response'
  end

  context 'when the request contains existing email' do
    let(:request_body_hash) {
      {
        email: 'ADMIN@example.org'
      }
    }

    before { send_json :post, described_endpoint, request_body_hash }

    it_behaves_like 'an unprocessable entity response'

    it 'returns email has already been taken error' do
      expect(parsed_body).to eq(errors: { email: ['has already been taken']})
    end
  end
end
