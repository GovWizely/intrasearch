require 'web_page_json_serializer'

module ArticleJSONSerializer
  def self.extended(base)
    base.extend WebPageJSONSerializer

    base.extra_attributes = {
      id: {
        key: :id
      }
    }

    base.snippet_attribute = :atom

    class << base
      attr_accessor :url_prefix
    end
    base.extend ModuleMethods
  end

  module ModuleMethods
    def serialize(resource)
      hash = super
      hash[:url] = "#{url_prefix}#{resource[:url_name]}"
      hash
    end
  end
end
