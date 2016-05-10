module WebPageHighlightBuilder
  def highlight(query_str, snippet_field_sym)
    return {} if query_str.blank?

    {
      fields: {
        snippet_field_sym => { fragment_size: 255, number_of_fragments: 1 },
        title: { number_of_fragments: 0 }
      }
    }
  end
end
