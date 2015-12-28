require 'nokogiri'

require 'owl_subclass_parser'

module TaxonomyExtractor
  def self.documents(resource:, root_label:)
    File.open(resource) do |f|
      xml = Nokogiri::XML f
      subclass_parser = OwlSubclassParser.new xml

      Enumerator.new do |y|
        subclass_parser.subnodes(root_label).each do |subnode_hash|
          y << subnode_hash.except(:id)
        end
      end
    end
  end
end
