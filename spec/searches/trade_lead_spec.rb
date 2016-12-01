require 'support/elastic_model_shared_contexts'

RSpec.describe TradeLead do
  include_context 'elastic models',
                  Country,
                  TradeLead::AustraliaTradeLead,
                  TradeLead::CanadaTradeLead,
                  TradeLead::Extra,
                  TradeLead::FboTradeLead,
                  TradeLead::McaTradeLead,
                  TradeLead::StateTradeLead,
                  TradeLead::UkTradeLead,
                  TradeLead::UstdaTradeLead,
                  TradeRegion,
                  WorldRegion

  describe '.ids' do
    it 'returns ids from all TradeLead models' do
      expected_ids = %w(
        AUSTRALIA-62d753fee98294cab8d66d1bcb501cff1a4f6670
        CANADA-539d317fe76effc1e7631ce1a7d2e6b814434f51
        FBO-995a1c55b26d11fe162f3f61b594be8c403c60f0
        MCA-f3a40a7987cd049cbf093079bbef65b1df387d00
        STATE-c118cb6ed4345bb33980b2dfb77303e2a561866a
        UK-d292a188d7ce8dd13419de8c0da4ce7b29c79899
        USTDA-26252346bf5f16c1a9a9b2dfa2762bbe2c99b8ae
      )
      expect(described_class.ids).to match_array(expected_ids)
    end
  end
end