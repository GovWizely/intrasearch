class TaxonomiesSettingsTemplate
  def to_hash
    {
      template: template_pattern,
      settings: {
        analysis: {
          char_filter: {
            replace_hyphen_filter: {
              type: 'pattern_replace',
              pattern: '-',
              replacement: ' '
            }
          },
          analyzer: {
            keyword_analyzer: {
              tokenizer: 'keyword',
              filter: %w(lowercase),
              char_filter: %w(replace_hyphen_filter)
            }
          }
        }
      }
    }
  end

  def template_pattern
    ['nix',
     Nix.env,
     'taxonomies', '*'].join('-')
  end
end
