module Webservices
  module Connection
    @middlewares = %i(mashify json raise_error).freeze

    class << self
      attr_reader :middlewares
    end

    def self.get_instance
      Faraday.new(url: Webservices.configuration.host_url) do |builder|
        middlewares.each do |middleware|
          builder.response middleware
        end
        builder.adapter Faraday.default_adapter
      end
    end
  end
end
