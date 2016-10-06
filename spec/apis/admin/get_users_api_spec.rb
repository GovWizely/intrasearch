require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe Admin::GetUsersAPI, endpoint: '/admin/users' do
  include APISpecHelpers

  include_context 'elastic models',
                  User

  include_context 'API response'

  context 'when user with upppercased matching email exists' do
    let(:email) { 'ADMIN@example.org' }

    before { get described_endpoint, 'email' => email }

    it_behaves_like 'a successful API response'

    it 'returns user with matching email' do
      expect(parsed_body.count).to eq(1)
      expect(parsed_body.first[:email]).to eq('admin@example.org')
    end
  end

  context 'when user with matching email does not exist' do
    let(:email) { 'foo@example.org' }

    before { get described_endpoint, 'email' => email }

    it_behaves_like 'a successful API response'
    it_behaves_like 'an empty array response'
  end

  context 'when user with matching reset_password_token exists' do
    let(:reset_password_token) { '$reset_password_token' }

    before { get described_endpoint, 'reset_password_token' => reset_password_token }

    it_behaves_like 'a successful API response'

    it 'returns user with matching reset_password_token' do
      expect(parsed_body.count).to eq(1)
      expect(parsed_body.first[:reset_password_token]).to eq(reset_password_token)
    end
  end

  context 'when user with matching reset_password_token does not exist' do
    let(:reset_password_token) { '$foo_reset_password_token' }

    before { get described_endpoint, 'reset_password_token' => reset_password_token }

    it_behaves_like 'a successful API response'
    it_behaves_like 'an empty array response'
  end

  context 'when user with matching unlock_token exists' do
    let(:unlock_token) { '$other_unlock_token' }

    before { get described_endpoint, 'unlock_token' => unlock_token }

    it_behaves_like 'a successful API response'

    it 'returns user with matching unlock_token' do
      expect(parsed_body.count).to eq(1)
      expect(parsed_body.first[:unlock_token]).to eq(unlock_token)
    end
  end

  context 'when user with matching unlock_token does not exist' do
    let(:unlock_token) { '$foo_unlock_token' }

    before { get described_endpoint, 'unlock_token' => unlock_token }

    it_behaves_like 'a successful API response'
    it_behaves_like 'an empty array response'
  end
end
