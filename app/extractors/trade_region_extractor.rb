require 'nokogiri'

require 'owl_region_country_parser'
require 'uneskos_member_parser'

module TradeRegionExtractor
  ROOT_LABEL = 'Trade Regions'.freeze

  def self.documents(resource)
    File.open(resource) do |f|
      xml = Nokogiri::XML f
      member_parser = UneskosMemberParser.new xml
      country_parser = OwlRegionCountryParser.new xml

      Enumerator.new do |y|
        member_parser.subnodes(ROOT_LABEL).each do |trade_region_hash|
          countries = country_parser.subnodes trade_region_hash[:label]
          trade_region_hash[:countries] = countries.map { |c| c[:label] }.sort
          y << trade_region_hash
        end
      end
    end
  end
end
