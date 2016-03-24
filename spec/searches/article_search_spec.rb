require 'rack_helper'

RSpec.describe ArticleSearch do
  include_context 'shared elastic models',
                  Country,
                  Industry,
                  Topic

  describe '.new' do
    subject(:search) { described_class.new options }

    context 'when countries is set' do
      let(:options) { { countries: '  UniteD  StateS , CanadA ' } }
      it { is_expected.to have_attributes(countries: ['  UniteD  StateS ', ' CanadA ']) }
    end

    context 'when industries is set' do
      let(:options) { { industries: ' FranchisinG , AerospacE and DefensE ' } }
      it { is_expected.to have_attributes(industries: [' FranchisinG ', ' AerospacE and DefensE ']) }
    end

    context 'when topics is set' do
      let(:options) { { topics: ' PriceS , tradE  promotioN ' } }
      it { is_expected.to have_attributes(topics: [' PriceS ',' tradE  promotioN ']) }
    end

    context 'when trade_regions is set' do
      let(:options) { { trade_regions: ' Trans Pacific PartnershiP ,  European Union - 28 ' } }
      it { is_expected.to have_attributes(trade_regions: [' Trans Pacific PartnershiP ',
                                                          '  European Union - 28 ']) }
    end

    context 'when types is not valid' do
      let(:options) { { types: ' foo bar ' } }
      it { is_expected.to have_attributes(types: [CountryCommercialGuide, MarketInsight, StateReport, TopMarketsReport]) }
    end

    context 'when types parameter contains countrycommercialguide' do
      let(:options) { { types: ' CountrY  CommerciaL  GuidE  ' } }
      it { is_expected.to have_attributes(types: [CountryCommercialGuide]) }
    end

    context 'when types parameter contains marketinsight' do
      let(:options) { { types: ' markeT insighT  ' } }
      it { is_expected.to have_attributes(types: [MarketInsight]) }
    end

    context 'when types parameter contains statereport' do
      let(:options) { { types: ' statE reporT  ' } }
      it { is_expected.to have_attributes(types: [StateReport]) }
    end

    context 'when types parameter contains topmarketsreport' do
      let(:options) { { types: ' toP markeTs  reporT  ' } }
      it { is_expected.to have_attributes(types: [TopMarketsReport]) }
    end

    context 'when world_regions is set' do
      let(:options) { { world_regions: ' invalid  , pacific  RIM  , westerN Hemisphere ' } }
      it { is_expected.to have_attributes(world_regions: [' invalid  ',
                                                          ' pacific  RIM  ',
                                                          ' westerN Hemisphere ']) }
    end
  end

  describe '#build_query_hash' do
    subject(:search) do
      described_class.new industries: 'Franchising, Aerospace and Defense',
                          limit: 1,
                          offset: 3,
                          q: 'south africa',
                          topics: 'Costing and Pricing, Environment',
                          trade_regions: 'NAFTA , Andean Community',
                          world_regions: ' pacific  RIM  , westerN Hemisphere '
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
        world_regions: [' pacific  RIM  ', ' westerN Hemisphere ']
      }
      expect(ArticleSearchQuery).to receive(:new).
                                      with(expected_query_params).
                                      and_return(foo: 'bar')

      expect(search.build_query).to eq(foo: 'bar')
    end
  end
end
