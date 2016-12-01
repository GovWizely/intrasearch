require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe Admin::TradeEventUpdateAPI, endpoint: '/admin/trade_events' do
  include APISpecHelpers

  include_context 'elastic models',
                  TradeEvent::DlTradeEvent,
                  TradeEvent::Extra,
                  TradeEvent::ItaTradeEvent,
                  TradeEvent::SbaTradeEvent,
                  TradeEvent::UstdaTradeEvent

  include_context 'API response'

  context 'when the request contains valid parameters' do
    let(:id) { 'DL-94c68284a1b7698becdcdaa69dda29bb2d76051c' }
    let(:request_body_hash) do
      {
        md_description: '#foo',
        html_description: '<h1>foo</h1>'
      }
    end

    before { send_json :patch, "#{described_endpoint}/#{id}", request_body_hash }

    it_behaves_like 'a successful no content API response'

    it 'saves trade event extra' do
      trade_event = TradeEvent.find_by_id id
      expect(trade_event.extra.md_description).to eq('#foo')
      expect(trade_event.extra.html_description).to eq('<h1>foo</h1>')
    end
  end

  context 'when existing extra is present' do
    let(:id) { 'ITA-36282' }
    let(:request_body_hash) do
      {
        md_description: '#foo',
        html_description: '<h1>foo</h1>'
      }
    end

    before { send_json :patch, "#{described_endpoint}/#{id}", request_body_hash }

    it 'overrides old attributes' do
      trade_event = TradeEvent.find_by_id id
      expect(trade_event.extra.md_description).to eq('#foo')
      expect(trade_event.extra.html_description).to eq('<h1>foo</h1>')
    end
  end

  context 'when the trade event is not found' do
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
