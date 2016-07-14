require 'uri'

module WebDocumentTransformer
  def self.transform(domain, hash)
    hash[:domain] = domain
    if hash[:url].present?
      hash[:url] = URI.join("http://#{domain}", hash[:url]).to_s
    end
  end
end
