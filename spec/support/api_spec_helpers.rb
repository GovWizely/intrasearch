module APISpecHelpers
  def app
    Intrasearch::Application
  end

  def described_endpoint
    scope = self.is_a?(Class) ? self :self.class
    scope.metadata[:endpoint].to_s
  end

  def send_json(method, path, body_hash)
    send method, path, JSON.generate(body_hash), 'CONTENT_TYPE' => 'application/json'
  end
end
