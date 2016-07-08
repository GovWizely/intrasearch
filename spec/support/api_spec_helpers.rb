module APISpecHelpers
  def self.included(base)
    base.include Rack::Test::Methods
  end

  def app
    Intrasearch::Application
  end

  def described_endpoint
    self.class.metadata[:endpoint].to_s
  end

  def send_json(method, path, body_hash)
    send method, path, JSON.generate(body_hash), 'CONTENT_TYPE' => 'application/json'
  end
end
