require 'owl_parser'

class OwlMemberRelatedParser
  include OwlParser

  self.subnode_path_template = <<-template
    //owl:Class
        [rdfs:subClassOf
          [owl:Restriction
            [owl:onProperty
              [@rdf:resource='http://purl.org/umu/uneskos#memberOf']
            ]
            [owl:someValuesFrom
              [@rdf:resource='%{member_subject}']
            ]
          ]
        ]
        [rdfs:subClassOf
          [owl:Restriction
            [owl:onProperty
              [@rdf:resource='http://www.w3.org/2004/02/skos/core#related']
            ]
            [owl:someValuesFrom
              [@rdf:resource='%{subject}']
            ]
          ]
        ]
  template

  def initialize(max_depth:, member_label:, xml:)
    super xml, max_depth
    @member_subject = extract_subject extract_root_node member_label
  end

  def template_format_args(subject)
    { member_subject: @member_subject, subject: subject }
  end
end
