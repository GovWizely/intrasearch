class WebDocumentsSettingsTemplate
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

  def template_pattern
    ['intrasearch', Intrasearch.env, 'web_documents', '*'].join('-')
  end
end
