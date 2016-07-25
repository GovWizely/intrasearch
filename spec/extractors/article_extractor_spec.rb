require 'support/base_article_extractor_shared_examples'

RSpec.describe ArticleExtractor do
  # include_examples 'base article extractor', 'Article__kav'

  describe '.extract' do
    let(:restforce_collection) do
      sobjects_hash = YAML.load Intrasearch.root.join('spec/fixtures/yaml/article_sobjects.yml').read
      [Restforce::Mash.build(sobjects_hash.first, nil)]
    end

    let(:expected_args) do
      {
        atom: 'item atom &amp; more atom',
        guide: 'STOPfakes',
        id: 'ka0t0000000PEieAAG',
        summary: 'item summary &amp; more summary',
        title: 'Item - Openness to &amp; Restriction on Foreign Investment',
        url_name: 'Item-Openness-to-Foreign-Investment',
        geographies: ['United States', 'Nicaragua'],
        industries: ['Satellites',
                     'Space Launch Equipment'],
        trade_topics: ['Trade Development and Promotion', 'Law']
      }
    end

    before do
      client = instance_double Restforce::Data::Client
      expect(Restforce).to receive(:new).and_return(client)
      expect(client).to receive(:query).and_return(restforce_collection)
    end

    it 'yields record' do
      extractor = described_class.extract
      expect { |block| extractor.each(&block) }.to yield_successive_args(expected_args)
    end
  end
end
