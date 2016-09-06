require 'show_json_serializer'

module LegacyTradeEventShowJSONSerializer
  def self.extended(base)
    base.extend ShowJSONSerializer

    base.module_eval do
      attribute :id
      attribute :name
      attribute :url, source_key: :hosted_url
      attribute :source
      attribute :event_url, source_key: :url
      attribute :description, method: :description
      attribute :cost
      attribute :registration_title
      attribute :registration_url
      attribute :start_date
      attribute :end_date
      attribute :countries, default: []
      attribute :industries, default: []
    end
  end

  extend self
end
