require 'support/webservices_importer_shared_contexts'

RSpec.describe TradeLead::FboTradeLeadImporter do
  describe '.import' do
    include_context 'webservices importer', Webservices::TradeLead

    it 'imports FBO trade leads' do
      expected_attributes = {
        id: 'FBO-995a1c55b26d11fe162f3f61b594be8c403c60f0',
        classification_code: 'U',
        click_url: 'https://goo.gl/fbo1',
        competitive_procurement_strategy: '$competitive_procurement_strategy',
        contact: 'Jane Doe',
        contract_number: 'sol-674-14-000014',
        countries: ['South Africa'],
        description: 'See RFP',
        end_at: DateTime.parse('2017-04-17T00:00:00+00:00'),
        expanded_industries: [
          'Business and Professional Services',
          'Scientific and Technical Services'
        ],
        hosted_url: 'https://example.org/trade_lead?id=FBO-995a1c55b26d11fe162f3f61b594be8c403c60f0',
        industries: [
          'Scientific and Technical Services'
        ],
        industry_paths: [
          '/Business and Professional Services/Scientific and Technical Services'
        ],
        notice_type: 'COMBINE',
        procurement_office: 'Overseas Missions',
        procurement_office_address: 'Dept of State Washington DC 20521-6120',
        procurement_organization: 'Agency for International Development',
        procurement_organization_address: 'South Africa USAID-Pretoria',
        published_at: DateTime.parse('2014-03-03T00:00:00+00:00'),
        source: 'FBO',
        specific_address: 'Regional Acquisition and Assistance Office',
        title: 'Education Activity Lead',
        trade_regions: [
          'African Growth and Opportunity Act',
          'South African Customs Union',
          'South African Development Community'
        ],
        url: 'https://www.fbo.org/url%20with%20spaces.html',
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
