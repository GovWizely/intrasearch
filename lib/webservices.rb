require 'active_support/core_ext/string/inflections'
require 'faraday'

require 'webservices/configuration'

module Webservices
  @configuration = Configuration.new

  class << self
    attr_reader :configuration
  end

  def self.configure
    yield @configuration
  end
end

require 'webservices/connection'
require 'webservices/resource'
require 'webservices/trade_event'
require 'webservices/trade_lead'
