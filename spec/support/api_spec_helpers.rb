module APISpecHelpers
  def app
    Intrasearch::Application
  end

  def described_endpoint
    scope = self.is_a?(Class) ? self :self.class
    scope.metadata[:endpoint].to_s
  end
end
