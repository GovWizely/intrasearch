require 'active_support/core_ext/object/to_param'

require 'support/webservices_shared_contexts'

RSpec.describe Webservices::TradeEvent do
  describe '.all' do
    context 'when the Webservices request is successful' do
      include_context 'webservices request', 200 do
        let(:request_path) do
          search_params = {
            api_key: 'webservices_api_key',
            offset: 0,
            size: 100
          }
          "/v1/trade_events/search?#{search_params.to_param}"
        end

        let(:response_file_path) { 'spec/fixtures/json/webservices/trade_events/all.json' }
      end

      it 'returns all trade events' do
        actual_trade_events = Webservices::TradeEvent.all.to_a
        expected_trade_events = [
          {
            'id' => '22346b67a36ab6acb9980bfefde51d2db041b5ed',
            'event_name' => 'Trade Event 1',
            'description' => 'Trade Event 1 Description',
            'url' => 'http://trade.event.example.org/1',
            'click_url' => 'https://goo.gl/dl1',
            'source' => 'DL'
          },
          {
            'id' => '94c68284a1b7698becdcdaa69dda29bb2d76051c',
            'event_name' => 'Trade Event 2',
            'description' => 'Trade Event 2 Description',
            'url' => 'http://trade.event.example.org/2',
            'click_url' => 'https://goo.gl/dl2',
            'source' => 'DL'
          }
        ]
        expect(actual_trade_events).to eq(expected_trade_events)
      end
    end

    context 'when the Webservices request is a bad request' do
      include_context 'webservices request', 400 do
        let(:request_path) do
          search_params = {
            api_key: 'webservices_api_key',
            offset: 0,
            size: 100,
            bad_param: 'bad'
          }
          "/v1/trade_events/search?#{search_params.to_param}"
        end

        let(:response_file_path) { 'spec/fixtures/json/webservices/unknown_parameters.json' }
      end

      it 'raises error' do
        expect { Webservices::TradeEvent.all(bad_param: 'bad').to_a }.to raise_error(Faraday::ClientError)
      end
    end
  end
end
