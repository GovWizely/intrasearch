require 'support/webservices_importer_shared_contexts'

RSpec.describe TradeLead::StateTradeLeadImporter do
  describe '.import' do
    include_context 'webservices importer', Webservices::TradeLead

    it 'imports STATE trade leads' do
      expected_attributes = {
        id: 'STATE-c118cb6ed4345bb33980b2dfb77303e2a561866a',
        borrowing_entity: 'Not Applicable',
        click_url: 'http://goo.gl/state1',
        comments: 'The value stated is not the correct value it is only for uploading purposes.',
        contact: 'NSB Fund Management',
        countries: ['Taiwan'],
        description: 'Expression of Interest',
        end_at: DateTime.parse('2016-08-24T00:00:00+00:00'),
        expanded_industries: ['Retail Trade'],
        funding_source: 'Other',
        hosted_url: 'https://example.org/trade_lead?id=STATE-c118cb6ed4345bb33980b2dfb77303e2a561866a',
        lead_source: 'Post Identified Project',
        industries: ['Retail Trade'],
        industry_paths: ['/Retail Trade'],
        procurement_organization: 'Ministry of Transport and Civil Aviation',
        project_number: 'NSB/SL/1601',
        project_size: 3240000000,
        published_at: DateTime.parse('2016-07-06T00:00:00+00:00'),
        record_id: 'DATATABLE.1667',
        source: 'STATE',
        specific_location: 'Western Province',
        status: 'Pipeline',
        submitting_officer: 'Jane Doe',
        submitting_officer_contact: 'jane@example.org',
        tags: ['A tag with extra spaces'],
        title: 'Taiwan Lead',
        trade_regions: ['Asia Pacific Economic Cooperation'],
        url: 'http://www.example.org/state',
        world_region_paths: [
          '/Asia',
          '/Asia Pacific',
          '/Asia/East Asia',
          '/Pacific Rim'
        ],
        world_regions: [
          'Asia',
          'Asia Pacific',
          'East Asia',
          'Pacific Rim'
        ]
      }

      described_class.import
      expect(model_class.count).to eq(1)
      expect(model_class.all.first).to have_attributes(expected_attributes)
    end
  end
end
