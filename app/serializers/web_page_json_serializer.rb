module WebPageJSONSerializer
  def self.extended(base)
    base.extend ModuleMethods

    class << base
      attr_accessor :snippet_attribute,
                    :title_attribute,
                    :extra_attributes
    end

    base.title_attribute = :title
    base.extra_attributes = {}
  end

  module ModuleMethods
    def serialize(resource)
      hash = {}
      extra_attributes.each do |attribute, attribute_options|
        hash[attribute] = resource[attribute_options[:key]]
      end
      assign_highlighted_fields resource, hash
      hash
    end

    protected

    def assign_highlighted_fields(resource, hash)
      if resource.hit['highlight']
        title_str = get_hit_value resource.hit, self.title_attribute
        snippet_str = get_hit_value resource.hit, self.snippet_attribute
      end

      title_str ||= resource[self.title_attribute]
      snippet_str ||= truncated_snippet resource[self.snippet_attribute]

      hash['title'] = title_str
      hash['snippet'] = build_snippet snippet_str
    end

    def get_hit_value(hit, field_symbol)
      highlighted_collection = hit['highlight'][field_symbol]
      highlighted_collection.first if highlighted_collection
    end

    def truncated_snippet(snippet_str)
      snippet_str.truncate(258, omission: ' ...', separator: /\s/) if snippet_str.present?
    end

    def build_snippet(snippet)
      if snippet.present?
        snippet.prepend('... ') unless snippet =~ /\A(<em>)?[A-Z]/
        snippet.concat(' ...') unless snippet =~ /\.\Z/
        snippet
      end
    end
  end
end
