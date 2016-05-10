module WebPageJSONSerializer
  def self.included(base)
    base.include InstanceMethods

    class << base
      attr_accessor :snippet_field,
                    :title_field,
                    :extra_json_fields
    end

    base.title_field = :title
    base.extra_json_fields = %i(url)
  end

  module InstanceMethods
    def attributes
      super.stringify_keys!
    end

    def as_json(options = nil)
      inject_highlighted_fields super({ only: self.class.extra_json_fields }.merge(options || {}))
    end

    private

    def inject_highlighted_fields(hash)
      if hit.highlight?
        title_str = get_highlighted_value hit, self.class.title_field
        snippet_str = get_highlighted_value hit, self.class.snippet_field
      end

      title_str ||= title
      snippet_str ||= truncated_snippet

      hash['title'] = title_str
      hash['snippet'] = build_snippet snippet_str
      hash
    end

    def get_highlighted_value(hit, field_symbol)
      highlighted_collection = hit.highlight[field_symbol]
      highlighted_collection.first if highlighted_collection
    end

    def truncated_snippet
      snippet_str = attributes[self.class.snippet_field.to_s]
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
