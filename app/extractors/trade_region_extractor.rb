require 'owl_member_related_parser'
require 'owl_member_parser'
require 'region_extractor'

module TradeRegionExtractor
  extend RegionExtractor
  extend self

  self.taxonomy_root_label = 'Trade Regions'.freeze

  protected

  def parser_hash(xml)
    {
      country: OwlMemberRelatedParser.new(max_depth: 1,
                                          member_label: 'Countries',
                                          xml: xml),
      member: OwlMemberParser.new(xml)
    }
  end
end
