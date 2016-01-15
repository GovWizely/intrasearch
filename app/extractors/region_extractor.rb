require 'nokogiri'

require 'owl_region_country_parser'
require 'uneskos_member_parser'

module RegionExtractor
  def self.extended(base)
    class << base
      attr_accessor :taxonomy_root_label
    end

    base.extend ModuleMethods
  end

  module ModuleMethods
    def documents(resource)
      File.open(resource) do |f|
        xml = Nokogiri::XML f
        member_parser = UneskosMemberParser.new xml
        country_parser = OwlRegionCountryParser.new xml

        Enumerator.new do |y|
          member_parser.subnodes(taxonomy_root_label).each do |region_hash|
            countries = country_parser.subnodes region_hash[:label]
            region_hash[:countries] = countries.map { |c| c[:label] }.sort
            y << region_hash
          end
        end
      end
    end
  end
end
