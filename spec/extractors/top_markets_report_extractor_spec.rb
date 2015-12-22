require 'rack_helper'

RSpec.describe TopMarketsReportExtractor do
  describe '.api_name' do
    subject { described_class.api_name }
    it { is_expected.to eq('Top_Markets__kav') }
  end

  describe '.query' do
    subject { described_class.query }
    it { is_expected.to include('FROM Top_Markets__kav') }
  end

  describe '.extract' do
    let(:restforce_collection) do
      sobjects_hash = YAML.load Nix.root.join('spec/fixtures/yaml/top_markets_report_sobjects.yml').read
      [Restforce::Mash.build(sobjects_hash.first, nil)]
    end

    before do
      client = instance_double Restforce::Data::Client
      expect(Restforce).to receive(:new).and_return(client)
      expect(client).to receive(:query).and_return(restforce_collection)
    end

    it 'yields record' do
      response = described_class.extract

      expected_hash = {
        atom: 'The 2015 Top Markets Report for Building Products and Sustainable Construction',
        id: 'ka6t0000000006sAAA',
        published_date: DateTime.parse('2015-10-23T20:23:00.000+0000'),
        summary: 'Canada ranks first among top export markets for U.S. building product manufacturers',
        title: 'Top Markets Title',
        geographies: ['Canada'],
        industries: ['Building Products'],
        trade_topics: ['Export Potential'],
        url_name: 'Top-Markets-Building-Products'
      }
      expect { |block| response.each(&block) }.to yield_with_args(expected_hash)
    end
  end
end
