RSpec.describe Webservices::Connection do
  describe '.get_instance' do
    subject { described_class.get_instance }

    it 'has configured handlers' do
      expected_handlers = [
        FaradayMiddleware::Mashify,
        FaradayMiddleware::ParseJson,
        Faraday::Response::RaiseError,
        Faraday::Adapter::Typhoeus
      ]
      expect(subject.builder.handlers).to eq(expected_handlers)
    end
  end
end
