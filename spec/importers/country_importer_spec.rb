require 'rack_helper'

RSpec.describe CountryImporter do
  describe '#import' do
    let(:subject) do
      described_class.new Nix.root.join('spec/fixtures/owls/countries.owl.xml')
    end

    let(:expected_args) do
      [{ id: 'country-RC4HD9CwKjvgX8dSybAp3Sk',
         label: 'United States',
         leaf_node: false,
         path: '/United States'},
       { id: 'country-RBTBNP5i0kFGFdhQ82AFali',
         label: 'Canada',
         leaf_node: true,
         path: '/Canada'},
       { id: 'country-RBPxtBToM2v2kOpsL8Gaifx',
         label: 'Cayman Islands',
         leaf_node: true,
         path: '/Cayman Islands'},
       { id: 'country-RBrLMfyIQS6WaDBWEPSZyzJ',
         label: 'Sweden',
         leaf_node: true,
         path: '/Sweden'}]
    end

    it 'creates Country' do
      expected_args.each do |industry_hash|
        expect(Country).to receive(:create).with(industry_hash)
      end
      subject.import
    end
  end
end
