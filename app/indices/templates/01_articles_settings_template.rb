class ArticlesSettingsTemplate
  def to_hash
    {
      template: template_pattern,
      settings: {
        analysis: {
          analyzer: {
            english_analyzer: {
              tokenizer: 'standard',
              filter: %w(standard asciifolding lowercase english_stemmer)
            },
            keyword_analyzer: {
              tokenizer: 'keyword',
              filter: %w(lowercase)
            },
            path_analyzer: {
              tokenizer: 'path_hierarchy',
              filter: %w(asciifolding)
            },
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

  def template_pattern
    ['nix', Nix.env, 'articles', '*'].join('-')
  end
end
