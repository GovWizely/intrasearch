RSpec.describe BaseArticleSearch do
  include_context 'shared elastic models',
                  Country,
                  Industry,
                  Topic

  describe '#build_query_hash' do
    subject(:search) do
      described_class.new industries: 'Franchising, Aerospace and Defense',
                          limit: 1,
                          offset: 3,
                          q: 'south africa',
                          topics: 'Costing and Pricing, Environment',
                          trade_regions: 'NAFTA , Andean Community',
                          world_regions: ' Pacific  Rim  , Western Hemisphere '
    end

    it 'searches using ArticleSearchQuery' do
      expected_query_params = {
        countries: [],
        industries: ['Franchising', ' Aerospace and Defense'],
        limit: 1,
        offset: 3,
        q: 'south africa',
        topics: ['Costing and Pricing', ' Environment'],
        trade_regions: ['NAFTA ', ' Andean Community'],
        world_regions: [' Pacific  Rim  ', ' Western Hemisphere ']
      }
      expect(BaseArticleSearchQuery).to receive(:new).
                                      with(expected_query_params).
                                      and_return(foo: 'bar')

      expect(search.build_query).to eq(foo: 'bar')
    end
  end
end
