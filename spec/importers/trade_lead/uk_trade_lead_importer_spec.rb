require 'support/webservices_importer_shared_contexts'

RSpec.describe TradeLead::UkTradeLeadImporter do
  describe '.import' do
    include_context 'webservices importer', Webservices::TradeLead

    it 'imports UK trade leads' do
      expected_attributes = {
        id: 'UK-d292a188d7ce8dd13419de8c0da4ce7b29c79899',
        click_url: 'http://goo.gl/uk1',
        contact: 'john@example.co.uk',
        contract_end_at: DateTime.parse('2022-03-13T00:00:00+00:00'),
        contract_start_at: DateTime.parse('2017-03-14T00:00:00+00:00'),
        countries: ['United Kingdom'],
        deadline_at: DateTime.parse('2016-09-19T00:00:00+00:00'),
        description: 'UK Business Services',
        expanded_industries: [
          'Aerospace and Defense',
          'Space'
        ],
        hosted_url: 'https://example.org/trade_lead?id=UK-d292a188d7ce8dd13419de8c0da4ce7b29c79899',
        industries: ['Space'],
        industry_paths: ['/Aerospace and Defense/Space'],
        max_contract_value: 6000000.0,
        min_contract_value: 0.0,
        notice_type: 'Contract',
        procurement_organization: 'UK BUSINESS',
        published_at: DateTime.parse('2016-08-15T09:21:36+00:00'),
        record_id: '355c8432-d59c-46d4-bd3e-015e3fd9fdd4',
        reference_number: 'PR16098',
        source: 'UK',
        specific_location: 'Any region',
        status: 'Open',
        title: 'Advanced Electron Microscopy Lead',
        trade_regions: ['European Union - 28'],
        url: 'http://www.example.co.uk/',
        world_region_paths: ['/Europe'],
        world_regions: ['Europe']
      }

      described_class.import
      expect(model_class.count).to eq(1)
      expect(model_class.all.first).to have_attributes(expected_attributes)
    end
  end
end
