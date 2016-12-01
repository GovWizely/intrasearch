require 'addressable/uri'
require 'uri'

require 'industry'
require 'namespaced_id_by_source_transformer'
require 'taxonomy_attributes_transformer'

module TradeLeadTransformer
  def self.extended(base)
    base.extend NamespacedIdBySourceTransformer
    base.extend TaxonomyAttributesTransformer
    base.extend ModuleMethods
  end

  URL_PREFIX = Intrasearch.config['trade_lead_url_prefix'].freeze

  module ModuleMethods
    def transform(attributes)
      transform_id attributes
      transform_country attributes
      transform_countries_and_regions attributes,
                                      attributes[:countries]
      attributes[:industries] &&= attributes[:industries].sort
      attributes[:expanded_industries] = attributes[:industries]
      transform_industries attributes, :expanded_industries
      transform_hosted_url attributes
      transform_urls attributes
      attributes
    end

    private

    def transform_country(attributes)
      attributes[:countries] = attributes[:country]
    end

    def transform_hosted_url(attributes)
      encoded_id = URI.encode_www_form_component attributes[:id]
      attributes[:hosted_url] = "#{URL_PREFIX}#{encoded_id}"
    end

    def transform_urls(attributes)
      attributes[:url] &&= normalize_url attributes[:url]
      attributes[:urls] &&= attributes[:urls].map { |url| normalize_url(url) }.compact
    end

    def normalize_url(url)
      url = "http://#{url}" unless url =~ /\Ahttps?:\/\//i
      Addressable::URI.parse(url).normalize.to_s rescue nil
    end
  end

  extend self
end
