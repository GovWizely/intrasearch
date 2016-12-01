require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe Admin::TradeLeadListAPI, endpoint: '/admin/trade_leads' do
  include APISpecHelpers

  include_context 'API response'

  context 'when trade leads are present' do
    include_context 'elastic models',
                    TradeLead::AustraliaTradeLead,
                    TradeLead::CanadaTradeLead,
                    TradeLead::Extra,
                    TradeLead::FboTradeLead,
                    TradeLead::McaTradeLead,
                    TradeLead::StateTradeLead,
                    TradeLead::UkTradeLead,
                    TradeLead::UstdaTradeLead

    before { get described_endpoint, 'limit' => 1, 'offset' => 2 }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 7,
                                           count: 1,
                                           offset: 2,
                                           next_offset: 3)
    end

    it 'returns trade leads' do
      actual_results = parsed_body[:results]
      expect(actual_results.count).to eq(1)

      expected_attributes = {
        id: 'MCA-f3a40a7987cd049cbf093079bbef65b1df387d00',
        categories: [
          'type/spn',
          'CPV/30236000',
          'CPV/30000000',
          'deadline/2017/Jun/09'
        ],
        click_url: 'http://goo.gl/mca1',
        country: 'South Africa',
        funding_source: 'Millennium Challenge Account (MCA)',
        hosted_url: 'https://example.org/trade_lead?id=MCA-f3a40a7987cd049cbf093079bbef65b1df387d00',
        html_description: '<h3>MILLENNIUM CHALLENGE ACCOUNT BENIN II.</h3>',
        md_description: '### MILLENNIUM CHALLENGE ACCOUNT BENIN II.',
        original_description: "Buyer: \u003Ca href=\"http://www.dgmarket.com/tenders/adminShowBuyer.do?buyerId=7041575\"\u003EMILLENNIUM CHALLENGE ACCOUNT BENIN II\u003C/a\u003E",
        published_at: '2016-06-18T21:10:41-04:00',
        source: 'MCA',
        title: 'Purchase of Computer Equipment Lead',
        url: 'http://www.dgmarket.com/tenders/np-notice.do?noticeId=14114655'
      }

      expect(actual_results.first).to eq(expected_attributes)
    end
  end

  context 'when there are no trade leads' do
    include_context 'elastic models',
                    TradeLead::AustraliaTradeLead,
                    TradeLead::CanadaTradeLead,
                    TradeLead::FboTradeLead,
                    TradeLead::McaTradeLead,
                    TradeLead::StateTradeLead,
                    TradeLead::UkTradeLead,
                    TradeLead::UstdaTradeLead,
                    skip_load_yaml: true

    before { get described_endpoint, 'limit' => 1, 'offset' => 2 }

    it_behaves_like 'a successful API response'

    it 'returns an empty array' do
      expect(parsed_body[:results]).to be_empty
    end
  end
end
