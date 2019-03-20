RSpec.shared_context 'webservices request' do |status_code|
  let(:response_body) { Intrasearch.root.join(response_file_path).read }

  before do
    connection = Faraday.new do |builder|
      Webservices::Connection.middlewares.each do |middleware|
        builder.response middleware
      end
      builder.adapter :test do |stub|
        stub.get(request_path) do |_env|
          [status_code, {}, response_body]
        end
      end
    end

    expect(Webservices::Connection).to receive(:get_instance).and_return(connection)
  end
end
