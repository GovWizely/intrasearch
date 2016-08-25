RSpec.describe TradeLeadTransformer do
  describe '.transform' do
    context 'when the URL contains spaces' do
      it 'encodes the spaces' do
        url = 'https://www.fbo.org/url with spaces.html'
        expected_url = 'https://www.fbo.org/url%20with%20spaces.html'
        expect(described_class.transform(url: url)[:url]).to eq(expected_url)
      end
    end

    context 'when the URL is not a valid' do
      it 'sets url to nil' do
        url = '01925 909877'
        expect(described_class.transform(url: url)[:url]).to be_nil
      end
    end
  end
end
