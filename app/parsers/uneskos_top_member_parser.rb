require 'owl_parser'

class UneskosTopMemberParser < OwlParser
  SUBNODE_PATH_TEMPLATE = <<-template
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

  def initialize(xml)
    super subnode_path_template: SUBNODE_PATH_TEMPLATE,
          xml: xml
  end
end
