require 'owl_parser'

class OwlSubclassParser
  include OwlParser

  self.subnode_path_template = <<-template
  //owl:Class
      [rdfs:subClassOf
        [@rdf:resource='%s']
      ]
  template
end
