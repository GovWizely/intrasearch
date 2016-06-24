RSpec.shared_examples 'a successful API response' do
  it 'returns success status' do
    expect(last_response.status).to eq(200)
  end
end

RSpec.shared_examples 'a resource not found API response' do
  it 'returns not found status' do
    expect(last_response.status).to eq(404)
  end
end

RSpec.shared_examples 'a bad request response' do
  it 'returns not found status' do
    expect(last_response.status).to eq(400)
  end
end

RSpec.shared_examples 'an empty array response' do
  it 'returns not found status' do
    expect(parsed_body.count).to eq(0)
  end
end
