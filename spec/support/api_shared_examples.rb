RSpec.shared_examples 'a successful API response' do
  it { is_expected.to have_attributes(status: 200) }
end

RSpec.shared_examples 'a resource not found API response' do
  it { is_expected.to have_attributes(status: 404) }
end

RSpec.shared_examples 'a bad request response' do
  it { is_expected.to have_attributes(status: 400) }
end

RSpec.shared_examples 'an empty array response' do
  it 'returns not found status' do
    expect(parsed_body.count).to eq(0)
  end
end

RSpec.shared_examples 'an empty metadata and results response' do
  it 'returns empty metadata and results' do
    aggregate_failures do
      expected_metadata = {
        total: 0,
        count: 0,
        offset: 0,
        next_offset: nil
      }
      expect(parsed_body[:metadata]).to eq(expected_metadata)
      expect(parsed_body[:results]).to be_empty
    end
  end
end
