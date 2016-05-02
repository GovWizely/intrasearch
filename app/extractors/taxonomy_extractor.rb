require 'nokogiri'

require 'owl_subclass_parser'
require 'owl_top_member_parser'

module TaxonomyExtractor
  module ModuleMethods
    def extract(resource:, root_label:)
      File.open(resource) do |f|
        xml = Nokogiri::XML f
        parsers = parser_hash xml

        Enumerator.new do |y|
          parsers[:member].subnodes(root_label).each do |member_hash|
            y << member_hash.except(:id)
            process_sub_member y, parsers, member_hash
          end
        end
      end
    end

    protected

    def parser_hash(xml)
      {
        member: OwlTopMemberParser.new(xml),
        sub_member: OwlSubclassParser.new(xml)
      }
    end

    def process_sub_member(yielder, parsers, member_hash)
      parsers[:sub_member].subnodes(member_hash[:label],
                                    member_hash[:path]).each do |sub_member_hash|
        yielder << sub_member_hash.except(:id)
      end
    end
  end

  extend ModuleMethods
end
