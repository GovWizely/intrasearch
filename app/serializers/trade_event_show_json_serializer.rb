module TradeEventShowJSONSerializer
  EXCLUDED_ATTRIBUTES = %i(
    countries
    created_at
    expanded_industries
    industry_paths
    original_description
    trade_regions
    updated_at
    world_region_paths
    world_regions
  ).freeze

  def self.serialize(resource)
    resource.as_json except: EXCLUDED_ATTRIBUTES.dup,
                     methods: 'description'
  end
end
