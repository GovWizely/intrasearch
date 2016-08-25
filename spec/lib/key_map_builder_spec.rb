RSpec.describe KeyMapBuilder do
  describe '.build' do
    context 'when the options contain attributes' do
      it 'generates hash with key for each attribute' do
        keys_options = {
          venues: {
            attributes: {
              country: {
                source_key: 'country_name'
              },
              venue: nil
            }
          }
        }

        actual_mappings = described_class.build keys_options

        expected_mappings = {
          venues: {
            source_key: 'venues',
            attributes: {
              country: {
                source_key: 'country_name'
              },
              venue: {
                source_key: 'venue'
              }
            }
          }
        }

        expect(actual_mappings).to eq(expected_mappings)
      end
    end
  end
end
