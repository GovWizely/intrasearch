require 'nokogiri'

module RegionExtractor
  def self.extended(base)
    class << base
      attr_accessor :taxonomy_root_label
    end

    base.extend ModuleMethods
  end

  module ModuleMethods
    def extract(resource)
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

    protected

    def process_region(yielder, parsers, region_hash)
      countries = parsers[:country].subnodes region_hash[:label]
      region_hash[:countries] = countries.map { |c| c[:label] }.sort
      yield region_hash if block_given?
      yielder << region_hash
    end
  end
end
