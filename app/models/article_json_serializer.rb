module ArticleJsonSerializer
  EXCLUDED_JSON_FIELDS = %i(atom created_at industry_paths summary title topic_paths updated_at).freeze
  
  def as_json(options = nil)
    inject_highlighted_fields super({ except: EXCLUDED_JSON_FIELDS }.merge(options || {}))
  end

  private

  def inject_highlighted_fields(hash)
    if hit.highlight
      snippets = hit.highlight.summary || hit.highlight.atom
      highlighted_title = hit.highlight.title.first if hit.highlight.title
    end
    snippets ||= [summary || atom]
    highlighted_title ||= title

    hash['title'] = highlighted_title

    collapsed_snippet = snippets.join(' ...')
    collapsed_snippet.prepend('... ') unless collapsed_snippet =~ /\A(<em>)?[A-Z]/
    collapsed_snippet.concat(' ...') unless collapsed_snippet =~ /\.\Z/
    hash['snippet'] = collapsed_snippet
    hash
  end
end
