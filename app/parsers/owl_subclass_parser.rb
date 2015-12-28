require 'owl_parser'

class OwlSubclassParser < OwlParser
  SUBNODE_PATH_TEMPLATE = <<-template
  //owl:Class
      [rdfs:subClassOf
        [@rdf:resource='%s']
      ]
  template

  def initialize(xml)
    super subnode_path_template: SUBNODE_PATH_TEMPLATE,
          xml: xml
  end
end
