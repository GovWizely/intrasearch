require 'owl_parser'

class OwlRegionCountryParser < OwlParser
  SUBNODE_PATH_TEMPLATE = <<-template
    //owl:Class
        [rdfs:subClassOf
          [owl:Restriction
            [owl:onProperty
              [@rdf:resource='http://purl.org/umu/uneskos#memberOf']
            ]
            [owl:someValuesFrom
              [@rdf:resource='%{countries}']
            ]
          ]
        ]
        [rdfs:subClassOf
          [owl:Restriction
            [owl:onProperty
              [@rdf:resource='http://www.w3.org/2004/02/skos/core#broader']
            ]
            [owl:someValuesFrom
              [@rdf:resource='%{subject}']
            ]
          ]
        ]
  template

  def initialize(xml)
    super subnode_path_template: SUBNODE_PATH_TEMPLATE,
          xml: xml
    @countries_subject = extract_subject extract_root_node('Countries')
  end

  def subnode_path(subject)
    @subnode_path_template % { countries: @countries_subject, subject: subject }
  end
end
