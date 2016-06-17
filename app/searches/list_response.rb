require 'search_response'

module ListResponse
  def self.included(base)
    class << base
      attr_accessor :serializer
    end
  end

  def initialize(search, results)
    @search = search
    @results = results
  end

  def to_json(options = nil)
    Yajl::Encoder.encode(as_json(options), html_safe: true)
  end

  def as_json(options = nil)
    run_results = {
      metadata: build_metadata_hash,
      results: as_json_results
    }
    run_results.as_json options
  end

  private

  def build_metadata_hash
    @count = @results.count
    @total = @results.total
    @next_offset = calculate_next_offset

    { total: @total,
      count: @count,
      offset: @search.offset,
      next_offset: @next_offset }
  end

  def calculate_next_offset
    next_offset_candidate = @count + @search.offset
    next_offset_candidate if next_offset_candidate < @total
  end

  def as_json_results
    @results.results.map do |result|
      self.class.serializer.serialize result
    end
  end
end
