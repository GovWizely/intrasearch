require 'support/elastic_model_shared_contexts'

RSpec.shared_context 'webservices importer' do |resource|
  let(:model_class) { described_class.name.sub(/Importer$/, '').constantize }
  let(:source) { model_class.name.demodulize.tableize.split('_').first.upcase }
  let(:json_response_path) { "spec/fixtures/json/#{resource.name.tableize}/#{source.downcase}.json" }

  include_context 'elastic models',
                  Country,
                  Industry

  before do
    json = Intrasearch.root.join(json_response_path).read
    trade_events = JSON.parse(json)['results']
    expect(resource).to receive(:all).
      with(sources: source).
      and_return(trade_events.to_enum)
  end
end
