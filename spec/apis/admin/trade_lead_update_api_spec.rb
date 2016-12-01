require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe Admin::TradeLeadUpdateAPI, endpoint: '/admin/trade_leads' do
  include APISpecHelpers

  include_context 'elastic models',
                  TradeLead::AustraliaTradeLead,
                  TradeLead::CanadaTradeLead,
                  TradeLead::Extra,
                  TradeLead::FboTradeLead,
                  TradeLead::McaTradeLead,
                  TradeLead::StateTradeLead,
                  TradeLead::UkTradeLead,
                  TradeLead::UstdaTradeLead

  include_context 'API response'

  context 'when the request contains valid parameters' do
    let(:id) { 'AUSTRALIA-62d753fee98294cab8d66d1bcb501cff1a4f6670' }
    let(:request_body_hash) do
      {
        md_description: '#foo',
        html_description: '<h1>foo</h1>'
      }
    end

    before { send_json :patch, "#{described_endpoint}/#{id}", request_body_hash }

    it_behaves_like 'a successful no content API response'

    it 'saves trade lead extra' do
      trade_lead = TradeLead.find_by_id id
      expect(trade_lead.extra.md_description).to eq('#foo')
      expect(trade_lead.extra.html_description).to eq('<h1>foo</h1>')
    end
  end

  context 'when existing extra is present' do
    let(:id) { 'CANADA-539d317fe76effc1e7631ce1a7d2e6b814434f51' }
    let(:request_body_hash) do
      {
        md_description: '#foo',
        html_description: '<h1>foo</h1>'
      }
    end

    before { send_json :patch, "#{described_endpoint}/#{id}", request_body_hash }

    it_behaves_like 'a successful no content API response'

    it 'overrides old attributes' do
      trade_lead = TradeLead.find_by_id id
      expect(trade_lead.extra.md_description).to eq('#foo')
      expect(trade_lead.extra.html_description).to eq('<h1>foo</h1>')
    end
  end

  context 'when the trade lead is not found' do
    let(:request_body_hash) do
      {
        md_description: '#foo',
        html_description: '<h1>foo</h1>'
      }
    end

    before { send_json :patch, "#{described_endpoint}/111", request_body_hash }

    it_behaves_like 'a resource not found API response'
  end
end
