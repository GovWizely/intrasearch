require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/filters'

module BaseArticleJsonSerializer
  INCLUDED_JSON_FIELDS = %i(id snippet title url).freeze

  def as_json(options = nil)
    inject_highlighted_fields super({ only: INCLUDED_JSON_FIELDS }.merge(options || {}))
  end

  private

  def inject_highlighted_fields(hash)
    if hit.highlight?
      title_str = hit.highlight.title.first if hit.highlight.title
      snippet_str = hit.highlight.atom.first if hit.highlight.atom
    end

    title_str ||= title
    snippet_str ||= truncated_atom

    hash['title'] = title_str
    hash['snippet'] = build_snippet snippet_str
    hash
  end

  def truncated_atom
    atom.truncate(258, omission: ' ...', separator: /\s/) if atom.present?
  end

  def build_snippet(snippet)
    if snippet.present?
      snippet.prepend('... ') unless snippet =~ /\A(<em>)?[A-Z]/
      snippet.concat(' ...') unless snippet =~ /\.\Z/
      snippet
    end
  end
end
