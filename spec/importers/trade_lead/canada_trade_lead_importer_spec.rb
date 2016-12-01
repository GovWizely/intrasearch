require 'support/webservices_importer_shared_contexts'

RSpec.describe TradeLead::CanadaTradeLeadImporter do
  describe '.import' do
    include_context 'webservices importer', Webservices::TradeLead

    it 'imports CANADA trade leads' do
      expected_attributes = {
        id: 'CANADA-539d317fe76effc1e7631ce1a7d2e6b814434f51',
        amended_at: DateTime.parse('2016-08-11T00:00:00+00:00'),
        amendment_number: '000',
        bid_type: 'All interested suppliers may submit a bid',
        click_urls: %w(https://goo.gl/canada1 https://goo.gl/canada2),
        competitive_procurement_strategy: 'N/A',
        contact: 'Jane Doe',
        contract_number: '47419-188062/B',
        countries: ['Canada'],
        description: 'Awesome description.',
        end_at: DateTime.parse('2016-09-20T00:00:00+00:00'),
        expanded_industries: [
          'Franchising',
          'Information and Communication Technology',
          'Retail Trade',
          'eCommerce Industry'
        ],
        hosted_url: 'https://example.org/trade_lead?id=CANADA-539d317fe76effc1e7631ce1a7d2e6b814434f51',
        implementing_entity: 'Canada Border Services Agency',
        industries: [
          'Franchising',
          'eCommerce Industry'
        ],
        industry_paths: [
          '/Franchising',
          '/Information and Communication Technology/eCommerce Industry',
          '/Retail Trade/eCommerce Industry'
        ],
        notice_type: 'APM-NPP',
        procurement_organization: 'Public Works and Government Services Canada',
        published_at: DateTime.parse('2016-08-10T00:00:00+00:00'),
        publishing_status: 'Active',
        reference_number: 'PW-$$BK-379-25940',
        source: 'CANADA',
        specific_location: 'Alberta',
        title: 'Awesome Lead',
        trade_agreement: 'World Trade Organization-Agreement',
        trade_regions: [
          'Asia Pacific Economic Cooperation',
          'NAFTA',
          'Trans Pacific Partnership'
        ],
        urls: [
          'https://tradelead.example.org/canada/1%20with%20spaces.pdf',
          'https://tradelead.example.org/canada/2.pdf'
        ],
        world_region_paths: [
          '/North America',
          '/Pacific Rim',
          '/Western Hemisphere'
        ],
        world_regions: [
          'North America',
          'Pacific Rim',
          'Western Hemisphere'
        ]
      }

      described_class.import
      expect(model_class.count).to eq(1)
      expect(model_class.all.first).to have_attributes(expected_attributes)
    end
  end
end
