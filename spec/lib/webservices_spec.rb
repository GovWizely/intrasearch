RSpec.describe Webservices do
  describe '.configuration' do
    subject { described_class.configuration }

    it 'has configured attributes' do
      expect(subject).to have_attributes(api_key: 'webservices_api_key',
                                         host_url: 'https://webservices.example.org')
    end
  end
end
