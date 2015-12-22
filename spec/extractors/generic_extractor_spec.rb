require 'rack_helper'

RSpec.describe GenericExtractor do
  describe '.api_name' do
    subject { described_class.api_name }
    it { is_expected.to eq('Generic__kav') }
  end

  describe '.query' do
    subject { described_class.query }
    it { is_expected.to include('FROM Generic__kav') }
  end

  describe '.extract' do
    let(:restforce_collection) do
      sobjects_hash = YAML.load Nix.root.join('spec/fixtures/yaml/article_sobjects.yml').read
      [Restforce::Mash.build(sobjects_hash.first, nil)]
    end

    let(:expected_args) do
      {
        atom: 'item atom',
        id: 'ka0t0000000PEieAAG',
        summary: 'item summary',
        title: 'Item - Openness to and Restriction on Foreign Investment',
        url_name: 'Item-Openness-to-Foreign-Investment',
        published_date: DateTime.parse('2015-10-23T20:23:00.000+0000'),
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
