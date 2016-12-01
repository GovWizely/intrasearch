require 'support/webservices_importer_shared_contexts'

RSpec.describe TradeLead::UstdaTradeLeadImporter do
  describe '.import' do
    include_context 'webservices importer', Webservices::TradeLead

    it 'imports USTDA trade leads' do
      expected_attributes = {
        id: 'USTDA-26252346bf5f16c1a9a9b2dfa2762bbe2c99b8ae',
        click_url: 'https://goo.gl/ustda1',
        countries: ['South Africa'],
        description: 'Background: a South African state-owned freight logistics company',
        end_at: DateTime.parse('2016-09-30T00:00:00+00:00'),
        hosted_url: 'https://example.org/trade_lead?id=USTDA-26252346bf5f16c1a9a9b2dfa2762bbe2c99b8ae',
        published_at: DateTime.parse('2016-06-13T00:00:00+00:00'),
        source: 'USTDA',
        title: 'Trade Lead: South Africa: Global Logistics Service Provider',
        trade_regions: [
          'African Growth and Opportunity Act',
          'South African Customs Union',
          'South African Development Community'
        ],
        url: 'https://www.example.org/ustda',
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
