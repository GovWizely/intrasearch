require 'uri'

module UrlTransformer
  def self.transform(attributes, prefix, suffix)
    if suffix.present?
      attributes[:url] = "#{prefix}#{URI.encode_www_form_component(suffix)}"
    end
  end
end
