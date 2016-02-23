require 'nokogiri'

require 'owl_member_parser'

module CountryExtractor
  ROOT_LABEL = 'Countries'.freeze

  def self.extract(resource)
    File.open(resource) do |f|
      xml = Nokogiri::XML f
      member_parser = OwlMemberParser.new xml

      Enumerator.new do |y|
        member_parser.subnodes(ROOT_LABEL).each do |country_hash|
          y << country_hash
        end
      end
    end
  end
end
