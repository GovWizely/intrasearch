RSpec.describe WebDocument do
  describe '#valid?' do
    context 'when title is blank' do
      subject(:document) { WebDocument.new(url: 'http://example.org/welcome') }
      it { is_expected.not_to be_valid }
    end

    context 'when url is blank' do
      subject(:document) { WebDocument.new(title: 'welcome') }
      it { is_expected.not_to be_valid }
    end
  end
end
