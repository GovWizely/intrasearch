require 'support/elastic_model_shared_contexts'

RSpec.describe QueryParser do
  include_context 'elastic models',
                  Country,
                  TradeRegion,
                  WorldRegion

  describe '.parse' do
    subject(:parsed_query_hash) { QueryParser.parse q }

    context "when query contains 'and' and punctuations" do
      let(:q) { 'foo, bar, baz-qux and fubar' }

      it 'returns non geo query' do
        expect(parsed_query_hash[:non_geo_name_query]).to eq('foo bar baz qux fubar')
      end

      it 'returns empty taxonomies' do
        expect(parsed_query_hash[:taxonomies]).to be_empty
      end
    end

    context 'when query contains multiple geo names' do
      let(:q) { 'healthcare Asia East Asia United States foo bar Asia Pacific Economic Cooperation' }

      subject(:parsed_query_hash) { QueryParser.parse q }

      it 'returns non geo query' do
        expect(parsed_query_hash[:non_geo_name_query]).to eq('healthcare foo bar')
      end

      it 'returns taxonomies' do
        expected_labels = [
          'Asia Pacific Economic Cooperation',
          'United States',
          'East Asia',
          'Asia'
        ]
        expect(parsed_query_hash[:taxonomies].map(&:label)).to eq(expected_labels)
      end
    end

    context 'when query contains hyphenated country name' do
      let(:q) { 'healthcare congo-brazzaville' }

      subject(:parsed_query_hash) { QueryParser.parse q }

      it 'returns non geo query' do
        expect(parsed_query_hash[:non_geo_name_query]).to eq('healthcare')
      end

      it 'returns taxonomies' do
        expect(parsed_query_hash[:taxonomies].map(&:label)).to eq(['Congo-Brazzaville'])
      end
    end

    context 'when taxonomy label contains hyphen and query does not contain hyphen' do
      let(:q) { 'healthcare congo Brazzaville foo bar' }

      subject(:parsed_query_hash) { QueryParser.parse q }

      it 'returns non geo query' do
        expect(parsed_query_hash[:non_geo_name_query]).to eq('healthcare foo bar')
      end

      it 'returns taxonomies' do
        expect(parsed_query_hash[:taxonomies].map(&:label)).to eq(['Congo-Brazzaville'])
      end
    end

    context "when taxonomy label contains 'and'" do
      let(:q) { 'healthcare bosnia and Herzegovina foo bar' }

      subject(:parsed_query_hash) { QueryParser.parse q }

      it 'returns non geo query' do
        expect(parsed_query_hash[:non_geo_name_query]).to eq('healthcare foo bar')
      end

      it 'returns taxonomies' do
        expect(parsed_query_hash[:taxonomies].map(&:label)).to eq(['Bosnia and Herzegovina'])
      end
    end

    context "when taxonomy label contains 'and' and query does not contain 'and'" do
      let(:q) { 'healthcare bosnia  Herzegovina' }

      subject(:parsed_query_hash) { QueryParser.parse q }

      it 'returns non geo query' do
        expect(parsed_query_hash[:non_geo_name_query]).to eq('healthcare')
      end

      it 'returns taxonomies' do
        expect(parsed_query_hash[:taxonomies].map(&:label)).to eq(['Bosnia and Herzegovina'])
      end
    end

    context 'when query can match multiple taxonomies' do
      let(:q) { 'healthcare East Asia' }

      subject(:parsed_query_hash) { QueryParser.parse q }

      it 'returns non geo query' do
        expect(parsed_query_hash[:non_geo_name_query]).to eq('healthcare')
      end

      it 'returns only the longest taxonomies' do
        expect(parsed_query_hash[:taxonomies].map(&:label)).to eq(['East Asia'])
      end
    end

    context 'when query contains comma' do
      let(:q) { 'healthcare palestine, state of' }

      subject(:parsed_query_hash) { QueryParser.parse q }

      it 'returns non geo query' do
        expect(parsed_query_hash[:non_geo_name_query]).to eq('healthcare')
      end

      it 'returns only the longest taxonomies' do
        expect(parsed_query_hash[:taxonomies].map(&:label)).to eq(['Palestine, State of'])
      end
    end

    context 'when taxonomy label contains command query does not contain comma' do
      let(:q) { 'healthcare palestine state of' }

      subject(:parsed_query_hash) { QueryParser.parse q }

      it 'returns non geo query' do
        expect(parsed_query_hash[:non_geo_name_query]).to eq('healthcare')
      end

      it 'returns only the longest taxonomies' do
        expect(parsed_query_hash[:taxonomies].map(&:label)).to eq(['Palestine, State of'])
      end
    end
  end
end
