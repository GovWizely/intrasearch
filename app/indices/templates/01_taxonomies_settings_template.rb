class TaxonomiesSettingsTemplate
  def to_hash
    {
      template: template_pattern,
      settings: {
        analysis: {
          analyzer: {
            keyword_analyzer: {
              tokenizer: 'keyword',
              filter: %w(lowercase asciifolding squish_filter trim),
              char_filter: %w(replace_punctuation_filter replace_stop_filter)
            },
            query_analyzer: {
              tokenizer: 'whitespace',
              filter: %w(lowercase asciifolding shingle_filter squish_filter trim unique),
              char_filter: %w(replace_punctuation_filter replace_stop_filter)
            }
          },
          char_filter: {
            replace_punctuation_filter: {
              type: 'pattern_replace',
              pattern: '-|,',
              replacement: ' '
            },
            replace_stop_filter: {
              type: 'pattern_replace',
              pattern: '\s*\band\b\s*',
              replacement: ' '
            }
          },
          filter: {
            shingle_filter: {
              type: 'shingle',
              filler_token: ' ',
              max_shingle_size: 5
            },
            squish_filter: {
              type: 'pattern_replace',
              pattern: '\s+',
              replacement: ' '
            }
          }
        }
      }
    }
  end

  def template_pattern
    ['intrasearch',
     Intrasearch.env,
     'taxonomies', '*'].join('-')
  end
end
