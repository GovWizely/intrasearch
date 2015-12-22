require 'active_support/core_ext/class/attribute'

module Extractable
  def self.extended(base)
    class << base
      attr_accessor :api_name
    end
  end
end
