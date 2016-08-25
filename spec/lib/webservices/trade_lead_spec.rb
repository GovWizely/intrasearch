require 'active_support/core_ext/object/to_param'

require 'support/webservices_shared_contexts'

RSpec.describe Webservices::TradeLead do
  describe '.all' do
    context 'when the Webservices request is successful' do
      include_context 'webservices request', 200 do
        let(:request_path) do
          search_params = {
            api_key: 'webservices_api_key',
            offset: 0,
            size: 100
          }
          "/v1/trade_leads/search?#{search_params.to_param}"
        end

        let(:response_file_path) { 'spec/fixtures/json/webservices/trade_leads/all.json' }
      end

      it 'returns all trade leads' do
        actual_trade_leads = Webservices::TradeLead.all.to_a
        expect(actual_trade_leads.count).to eq(7)
        expected_trade_leads = JSON.parse(Intrasearch.root.join(response_file_path).read)['results']
        expect(actual_trade_leads).to eq(expected_trade_leads)
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
          "/v1/trade_leads/search?#{search_params.to_param}"
        end

        let(:response_file_path) { 'spec/fixtures/json/webservices/unknown_parameters.json' }
      end

      it 'raises error' do
        expect { Webservices::TradeLead.all(bad_param: 'bad').to_a }.to raise_error(Faraday::ClientError)
      end
    end
  end
end
