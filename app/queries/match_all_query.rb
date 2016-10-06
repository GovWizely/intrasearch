module MatchAllQuery
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    def initialize(limit:, offset:)
      @limit = limit
      @offset = offset
    end

    def to_hash
      {
        query: {
          match_all: {}
        },
        from: @offset,
        size: @limit
      }
    end
  end
end