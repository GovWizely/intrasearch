require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe Admin::UpdateUserAPI, endpoint: '/admin/users/%{id}' do
  include APISpecHelpers

  include_context 'elastic models',
                  User

  include_context 'API response'

  context 'when the request contains valid parameters' do
    let(:id) { 'AVV-WR5f1r3iRzHwsCgc' }
    let(:request_body_hash) {
      {
        email: 'foo@example.org',
        encrypted_password: '$new_encrypted_password',
        reset_password_token: '$new_encrypted_password',
        reset_password_sent_at: nil,
        remember_created_at: nil,
        sign_in_count: 1,
        current_sign_in_at: nil,
        last_sign_in_at: nil,
        current_sign_in_ip: '$current_sign_in_ip',
        last_sign_in_ip: '$last_sign_in_ip',
        failed_attempts: 1,
        unlock_token: '$unlock_token',
        locked_at: DateTime.parse('Wed, 22 Jun 2016 17:54:24 +0000')
      }
    }

    before { send_json :patch, (described_endpoint % { id: id }), request_body_hash }

    it_behaves_like 'a successful no content API response'

    it 'saves all attributes' do
      user = User.find id
      expect(user).to have_attributes(request_body_hash)
    end
  end

  context 'when the request contains invalid parameters' do
    let(:id) { 'AVV-Zgpz1r3iRzHwsCge' }
    let(:request_body_hash) do
      {
        email: nil
      }
    end

    before { send_json :patch, (described_endpoint % { id: id }), request_body_hash }

    it_behaves_like 'an unprocessable entity response'

    it 'returns errors' do
      expect(parsed_body).to eq(errors: { email: ["can't be blank"] })
    end

    it 'leaves user attributes unchanged' do
      user = User.find id
      expect(user.email).to eq('other@example.org')
    end
  end

  context 'when user is not found' do
    let(:id) { 'notpresent' }
    let(:request_body_hash) do
      {
        email: 'notpresent@example.org'
      }
    end

    before { send_json :patch, (described_endpoint % { id: id }), request_body_hash }

    it_behaves_like 'a resource not found API response'
  end
end
