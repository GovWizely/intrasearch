module Search
  DEFAULT_LIMIT = 10
  DEFAULT_OFFSET = 0

  MAX_LIMIT = 20
  MAX_OFFSET = 999

  attr_reader :limit,
              :offset

  def initialize(options)
    @limit = options[:limit] || DEFAULT_LIMIT
    @offset = options[:offset] || DEFAULT_OFFSET
    @q = options[:q]
    @search_type = options[:search_type]
  end

  def search_type_count?
    :count == @search_type
  end
end
