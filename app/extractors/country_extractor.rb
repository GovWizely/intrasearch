require 'nokogiri'

require 'uneskos_member_parser'

module CountryExtractor
  ROOT_LABEL = 'Countries'.freeze

  def self.documents(resource)
    File.open(resource) do |f|
      xml = Nokogiri::XML f
      member_parser = UneskosMemberParser.new xml

      Enumerator.new do |y|
        member_parser.subnodes(ROOT_LABEL).each do |trade_region_hash|
          y << trade_region_hash
        end
      end
    end
  end
end
