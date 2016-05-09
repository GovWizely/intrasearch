require 'support/elastic_model_shared_contexts'

RSpec.shared_context 'trade event importer' do
  let(:model_class) { described_class.name.sub(/Importer$/, '').constantize }
  let(:source) { described_class.name.demodulize.sub(/TradeEventImporter$/, '').upcase }
  let(:json_response_path) { "spec/fixtures/json/webservices/#{source.downcase}_trade_events.json" }

  include_context 'elastic models',
                  Country,
                  Industry

  before do
    json = Intrasearch.root.join(json_response_path).read
    trade_events = JSON.parse(json)['results']
    expect(Webservices::TradeEvent).to receive(:all).
                                         with(sources: source).
                                         and_return(trade_events.to_enum)
  end
end
