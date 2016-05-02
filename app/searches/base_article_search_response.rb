class BaseArticleSearchResponse
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
      aggregations: build_aggregations,
    }
    run_results[:results] = @results.results unless @search.limit.zero?
    run_results.as_json options
  end

  private

  def build_metadata_hash
    @total = @results.total
    return { total: @total } if @search.limit.zero?

    @count = @results.count
    @next_offset = calculate_next_offset

    { total: @total,
      count: @count,
      offset: @search.offset,
      next_offset: @next_offset }
  end

  def build_aggregations
    aggregations = @results.response.aggregations
    %w(countries industries topics trade_regions types world_regions).each do |agg|
      aggregations[agg] &&= aggregations[agg]['buckets']
    end
    aggregations
  end

  def calculate_next_offset
    next_offset_candidate = @count + @search.offset
    if next_offset_candidate < @total && next_offset_candidate <= Search::MAX_OFFSET
      next_offset_candidate
    else
      nil
    end
  end
end
