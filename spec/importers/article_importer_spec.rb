require 'support/base_article_importer_shared_examples'
require 'support/elastic_model_shared_contexts'

RSpec.describe ArticleImporter do
  include_context 'elastic models',
                  Country,
                  Industry,
                  Topic

  describe '#import' do
    let(:extracted_args) do
      YAML.load Intrasearch.root.join('spec/fixtures/yaml/extracted_articles.yml').read
    end

    before do
      expect(ArticleExtractor).to receive(:extract).and_return(extracted_args.to_enum)
    end

    it 'imports CountryCommercial' do
      described_class.import
      expect(described_class.model_class.count).to eq(3)

      expected_attributes = {
        id: 'ka0t0000000PONvAAO',
        atom: 'item 1 atom',
        countries: ['Cayman Islands',
                    'United States'],
        guide: 'STOPfakes',
        industries: ['Aerospace and Defense',
                     'Information and Communication Technology',
                     'Retail Trade',
                     'Satellites',
                     'Space',
                     'Space Launch Equipment',
                     'eCommerce Industry'],
        industry_paths: ['/Aerospace and Defense/Space/Satellites',
                         '/Aerospace and Defense/Space/Space Launch Equipment',
                         '/Information and Communication Technology/eCommerce Industry',
                         '/Retail Trade/eCommerce Industry'],
        summary: 'item 1 summary',
        title: 'item 1 title',
        topic_paths: ['/Business Management',
                      '/Environment/Climate',
                      '/Market Access/Export Licenses',
                      '/Market Access/Trade Barriers/Anti-Dumping',
                      '/Transport and Logistics/Trade Documents/Export Licenses'],
        topics: ['Anti-Dumping',
                 'Business Management',
                 'Climate',
                 'Environment',
                 'Export Licenses',
                 'Market Access',
                 'Trade Barriers',
                 'Trade Documents',
                 'Transport and Logistics'],
        trade_regions: ['Asia Pacific Economic Cooperation'],
        url: 'https://example.org/article?id=Space-Business',
        url_name: 'Space-Business',
        world_region_paths: ['/Caribbean',
                             '/North America',
                             '/Pacific Rim',
                             '/Western Hemisphere'],
        world_regions: ['Caribbean',
                        'North America',
                        'Pacific Rim',
                        'Western Hemisphere']
      }
      item = described_class.model_class.find(extracted_args[0][:id])
      expect(item).to have_attributes(expected_attributes)
    end
  end
end
