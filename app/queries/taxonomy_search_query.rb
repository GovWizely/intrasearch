require 'active_support/core_ext/string/filters'

class TaxonomySearchQuery
  def initialize(labels)
    @labels = labels.map { |l| l.downcase.squish.gsub('-', ' ') }
  end

  def to_hash
    {
      query: {
        filtered: {
          filter: [
            { terms: { label: @labels } }
          ]
        }
      }
    }
  end
end
