RSpec.shared_examples 'article importer' do |extractor_class|
  describe '#import' do
    let(:extracted_args) do
      YAML.load Nix.root.join('spec/fixtures/yaml/extracted_articles.yml').read
    end

    before do
      expect(extractor_class).to receive(:extract).and_return(extracted_args.to_enum)
    end

    it 'imports CountryCommercial' do
      described_class.new.import
      expect(described_class.model_class.count).to eq(3)

      expected_attributes = {
        id: 'ka0t0000000PONvAAO',
        atom: 'item 1 atom',
        countries: ['Cayman Islands',
                    'United States'],
        industries: ['Satellites',
                     'Space Launch Equipment',
                     'eCommerce Industry'],
        industry_paths: ['/Aerospace and Defense/Space/Satellites',
                         '/Aerospace and Defense/Space/Space Launch Equipment',
                         '/Information and Communication Technology/eCommerce Industry',
                         '/Retail Trade/eCommerce Industry'],
        summary: 'item 1 summary',
        topic_paths: ['/Business Management',
                      '/Environment/Climate',
                      '/Market Access/Export Licenses',
                      '/Market Access/Trade Barriers/Anti-Dumping',
                      '/Transport and Logistics/Trade Documents/Export Licenses'],
        topics: ['Anti-Dumping',
                 'Business Management',
                 'Climate',
                 'Export Licenses'],
        title: 'item 1 title',
        url: 'https://example.org/article2?id=Space-Business',
      }
      item = described_class.model_class.find(extracted_args[0][:id])
      expect(item).to have_attributes(expected_attributes)
    end
  end

end
