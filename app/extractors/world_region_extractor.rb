require 'region_extractor'

module WorldRegionExtractor
  extend RegionExtractor
  extend self

  self.taxonomy_root_label = 'World Regions'.freeze

  def parser_hash(xml)
    {
      member: UneskosTopMemberParser.new(xml),
      country: OwlRegionCountryParser.new(xml),
      subregion: OwlSubclassParser.new(xml)
    }
  end

  def process_region(yielder, parsers, region_hash)
    super do
      parsers[:subregion].subnodes(region_hash[:label],
                                   region_hash[:path]).each do |subregion_hash|
        process_region yielder, parsers, subregion_hash
      end
    end
  end
end
