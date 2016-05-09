RSpec.shared_examples 'a successful API response' do
  it 'returns success status' do
    expect(last_response.status).to eq(200)
  end
end
