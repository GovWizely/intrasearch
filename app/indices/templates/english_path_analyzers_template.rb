module EnglishPathAnalyzersTemplate
  def to_hash
    {
      template: template_pattern,
      settings: {
        analysis: {
          analyzer: {
            english_analyzer: {
              tokenizer: 'standard',
              filter: %w(standard asciifolding lowercase stop english_stemmer),
              char_filter: %w(html_strip)
            },
            path_analyzer: {
              tokenizer: 'path_hierarchy',
              filter: %w(asciifolding)
            }
          },
          filter: {
            english_stemmer: {
              type: 'stemmer',
              name: 'minimal_english'
            }
          }
        }
      }
    }
  end
end
