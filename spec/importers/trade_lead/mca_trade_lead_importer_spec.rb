require 'support/webservices_importer_shared_contexts'

RSpec.describe TradeLead::McaTradeLeadImporter do
  describe '.import' do
    include_context 'webservices importer', Webservices::TradeLead

    it 'imports MCA trade leads' do
      expected_attributes = {
        id: 'MCA-f3a40a7987cd049cbf093079bbef65b1df387d00',
        categories: [
          'type/spn',
          'CPV/30236000',
          'CPV/30000000',
          'deadline/2017/Jun/09'
        ],
        click_url: 'http://goo.gl/mca1',
        countries: ['South Africa'],
        description: "Buyer: \u003Ca href=\"http://www.dgmarket.com/tenders/adminShowBuyer.do?buyerId=7041575\"\u003EMILLENNIUM CHALLENGE ACCOUNT BENIN II\u003C/a\u003E",
        funding_source: 'Millennium Challenge Account (MCA)',
        hosted_url: 'https://example.org/trade_lead?id=MCA-f3a40a7987cd049cbf093079bbef65b1df387d00',
        source: 'MCA',
        published_at: DateTime.parse('2016-06-18T21:10:41-04:00'),
        title: 'Purchase of Computer Equipment Lead',
        url: 'http://www.dgmarket.com/tenders/np-notice.do?noticeId=14114655',
        trade_regions: [
          'African Growth and Opportunity Act',
          'South African Customs Union',
          'South African Development Community'
        ],
        world_region_paths: [
          '/Africa',
          '/Africa/Sub-Saharan Africa'
        ],
        world_regions: [
          'Africa',
          'Sub-Saharan Africa'
        ]
      }

      described_class.import
      expect(model_class.count).to eq(1)
      expect(model_class.all.first).to have_attributes(expected_attributes)
    end
  end
end
