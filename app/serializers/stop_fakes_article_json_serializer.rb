require 'web_page_json_serializer'

module StopFakesArticleJSONSerializer
  extend WebPageJSONSerializer

  URL_PREFIX = Intrasearch.config['stop_fakes_article_url_prefix'].freeze

  self.extra_attributes = {
    id: {
      key: :id
    }
  }

  self.snippet_attribute = :atom
  self.title_attribute = :title


  module ModuleMethods
    def serialize(resource)
      hash = super
      hash[:url] = "#{URL_PREFIX}#{resource[:url_name]}"
      hash
    end
  end

  extend ModuleMethods
end
