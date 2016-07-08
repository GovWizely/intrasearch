require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe Admin::GetUserAPI, endpoint: '/admin/users/%{id}' do
  include APISpecHelpers

  include_context 'elastic models',
                  User

  include_context 'API response'

  context 'when a user with matching id exists' do
    let(:id) { 'AVV-Zgpz1r3iRzHwsCge' }

    before { get (described_endpoint % { id: id }) }

    it_behaves_like 'a successful API response'

    it 'returns matching user' do
      expect(parsed_body[:email]).to eq('other@example.org')
    end
  end

  context 'when a user with matching id does not exist' do
    let(:id) { 'foo' }

    before { get (described_endpoint % { id: id }) }

    it_behaves_like 'a resource not found API response'
  end
end
