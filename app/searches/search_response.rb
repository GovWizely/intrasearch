require 'active_support/core_ext/class/attribute'

require 'search'

module SearchResponse
  def self.included(base)
    base.module_eval do
      base.class_attribute :serializer,
                           instance_writer: false
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
    }
    run_results[:results] = as_json_results unless @search.search_type_count?
    yield run_results if block_given?

    run_results
  end

  private

  def build_metadata_hash
    @total = @results.total
    return { total: @total } if @search.search_type_count?

    @count = @results.count
    @next_offset = calculate_next_offset

    { total: @total,
      count: @count,
      offset: @search.offset,
      next_offset: @next_offset }
  end

  def calculate_next_offset
    next_offset_candidate = @count + @search.offset
    if next_offset_candidate < @total && next_offset_candidate <= Search::MAX_OFFSET
      next_offset_candidate
    end
  end

  def as_json_results
    @results.results.map do |result|
      self.class.serializer.serialize result
    end
  end

  def build_aggregations
    aggregations = @results.response.aggregations
    aggregations.keys.each do |agg|
      aggregations[agg] &&= aggregations[agg]['buckets']
    end
    aggregations
  end
end
