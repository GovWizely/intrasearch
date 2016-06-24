RSpec.shared_context 'API response' do
  subject { last_response }
  let(:parsed_body) { JSON.parse(last_response.body, symbolize_names: true) }
end

