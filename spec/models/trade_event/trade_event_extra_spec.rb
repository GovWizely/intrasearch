require 'support/elastic_model_shared_contexts'

RSpec.describe TradeEvent::TradeEventExtra do
  include_context 'elastic models',
                  described_class

  describe '.create' do
    context 'when the attribute values are blank' do
      subject do
        described_class.create id: '100',
                               md_description: '  ',
                               html_description: '  '
      end

      it { is_expected.to have_attributes(md_description: nil,
                                          html_description: nil) }
    end

    context 'when the attribute values contain newline' do
      subject do
        described_class.create id: '100',
                               md_description: " foo\nbar ",
                               html_description: " bar\nfoo "
      end

      it { is_expected.to have_attributes(html_description: " bar\nfoo ",
                                          md_description: " foo\nbar ") }
    end
  end
end
