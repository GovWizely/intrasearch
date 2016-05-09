module WebPageHighlightBuilder
  def self.build(query_str, title_field: :title, snippet_field:)
    return {} if query_str.blank?

    {
      fields: {
        snippet_field => { fragment_size: 255, number_of_fragments: 1 },
        title_field => { number_of_fragments: 0 }
      }
    }
  end
end
