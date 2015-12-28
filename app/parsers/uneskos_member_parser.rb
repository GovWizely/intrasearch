require 'owl_parser'

class UneskosMemberParser < OwlParser
  SUBNODE_PATH_TEMPLATE = <<-template
    //owl:Class
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
