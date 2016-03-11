class MatchLabelQuery
  def initialize(labels)
    @labels = labels
  end

  def to_hash
    {
      query: {
        filtered: {
          query: {
            bool: {
              should: match_labels
            }
          }
        }
      }
    }
  end

  private

  def match_labels
    @labels.map do |label|
      { match: { label: label } }
    end
  end
end
