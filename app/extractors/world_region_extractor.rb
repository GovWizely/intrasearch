require 'owl_member_narrower_parser'
require 'owl_subclass_parser'
require 'owl_top_member_parser'
require 'region_extractor'

module WorldRegionExtractor
  extend RegionExtractor
  extend self

  self.taxonomy_root_label = 'World Regions'.freeze

  protected

  def parser_hash(xml)
    {
      country: OwlMemberNarrowerParser.new(member_label: 'Countries',
                                           xml: xml),
      subregion: OwlSubclassParser.new(xml),
      member: OwlTopMemberParser.new(xml)
    }
  end

  def process_region(yielder, parsers, region_hash)
    super do
      parsers[:subregion].subnodes(region_hash[:label],
                                   region_hash[:path]).each do |subregion_hash|
        process_region yielder, parsers, subregion_hash
        region_hash[:countries] |= subregion_hash[:countries]
        region_hash[:countries].sort!
      end
    end
  end
end
