class ArticlesSettingsTemplate
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
            keyword_analyzer: {
              tokenizer: 'keyword',
              filter: %w(lowercase asciifolding)
            },
            path_analyzer: {
              tokenizer: 'path_hierarchy',
              filter: %w(asciifolding)
            }
          },
          filter: {
            english_stemmer: {
              type: 'stemmer',
              language: 'porter2'
            }
          }
        }
      }
    }
  end

  def template_pattern
    ['intrasearch', Intrasearch.env, 'articles', '*'].join('-')
  end
end
