RSpec.describe AttributeMappingBuilder do
  describe '.build' do
    context 'when the name is specified' do
      it 'generates hash with default key' do
        actual_mappings = described_class.build :id
        expected_mappings = {
          id: {
            key: 'id'
          }
        }
        expect(actual_mappings).to eq(expected_mappings)
      end
    end

    context 'when the options contain a Hash with key' do
      it 'generates hash with the specified key' do
        actual_mappings = described_class.build :id, key: 'identifier'
        expected_mappings = {
          id: {
            key: 'identifier'
          }
        }
        expect(actual_mappings).to eq(expected_mappings)
      end
    end

    context 'when the options contain attributes' do
      let(:input_mappings) do
        [
          {
            venues: {
              attributes: [
                {
                  country: {
                    key: 'country_name'
                  }
                },
                :venue
              ]
            }
          }
        ]
      end

      it 'generates hash with key for each attribute' do
        actual_mappings = described_class.build :venues,
                                                attributes: [
                                                  { country: { key: 'country_name' } },
                                                  :venue
                                                ]
        expected_mappings = {
          venues: {
            key: 'venues',
            attributes: {
              venue: {
                key: 'venue'
              },
              country: {
                key: 'country_name'
              }
            }
          }
        }
        expect(actual_mappings).to eq(expected_mappings)
      end
    end
  end
end
