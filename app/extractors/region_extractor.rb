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
        parsers = parser_hash xml

        Enumerator.new do |y|
          parsers[:member].subnodes(taxonomy_root_label).each do |region_hash|
            process_region y, parsers, region_hash
          end
        end
      end
    end

    def parser_hash(xml)
      {
        member: UneskosMemberParser.new(xml),
        country: OwlRegionCountryParser.new(xml)
      }
    end

    def process_region(yielder, parsers, region_hash)
      countries = parsers[:country].subnodes region_hash[:label]
      region_hash[:countries] = countries.map { |c| c[:label] }.sort
      yielder << region_hash
      yield region_hash if block_given?
    end
  end
end
