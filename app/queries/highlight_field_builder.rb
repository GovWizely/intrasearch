module HighlightFieldBuilder
  def build(field_symbol, q, number_of_fragment = 1)
    {
      fragment_size: 255,
      highlight_query: {
        match: {
          field_symbol => q
        }
      },
      number_of_fragments: number_of_fragment
    }
  end

  extend self
end
