RSpec.shared_examples 'API response' do
  it 'returns success status' do
    expect(last_response.status).to eq(200)
  end

  it 'returns aggregations' do
    expected_keys = %i(countries industries topics trade_regions types world_regions)
    expect(parsed_body[:aggregations].keys.sort).to eq(expected_keys)
  end
end
