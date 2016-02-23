require 'owl_parser'

class OwlMemberParser
  include OwlParser

  self.subnode_path_template = <<-template
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
end
