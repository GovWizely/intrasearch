require 'owl_parser'

class OwlTopMemberParser
  include OwlParser

  self.subnode_path_template = <<-template
    //owl:Class
        [rdfs:subClassOf
          [@rdf:resource='http://www.w3.org/2004/02/skos/core#Concept']
        ]
        [rdfs:subClassOf
          [owl:Restriction
            [owl:onProperty
              [@rdf:resource='http://purl.org/umu/uneskos#memberOf']
            ]
            [owl:someValuesFrom
              [@rdf:resource='%s']
            ]
          ]
        ]
  template
end
