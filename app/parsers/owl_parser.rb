class OwlParser
  NAMESPACE_HASH = {
    owl: 'http://www.w3.org/2002/07/owl#',
    rdf: 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
    rdfs: 'http://www.w3.org/2000/01/rdf-schema#' }.freeze

  def initialize(subnode_path_template:, xml:)
    @subnode_path_template = subnode_path_template
    @xml = xml
  end

  def subnodes(root_label, starting_path = nil)
    root_node = extract_root_node root_label
    Enumerator.new do |y|
      process_subnodes y,
                       extract_node_hash(root_node).merge(path: starting_path)
    end
  end

  protected

  def extract_root_node(root_label)
    @xml.xpath("//owl:Class[rdfs:label[.='#{root_label}']]", NAMESPACE_HASH).first
  end

  def process_subnodes(yielder, node_hash)
    node_hash[:subnodes].each do |subnode|
      subnode_hash = extract_node_hash subnode, node_hash[:path]
      yielder << subnode_hash.except(:subnodes, :subject)

      process_subnodes yielder, subnode_hash
    end
  end

  def extract_node_hash(node, parent_path = nil)
    label = extract_label node
    path = build_path parent_path, label
    subject = extract_subject node
    subnodes = extract_subnodes node

    { id: subject,
      label: label,
      path: path,
      subnodes: subnodes }
  end

  def extract_label(node)
    text = node.xpath './rdfs:label/text()', NAMESPACE_HASH
    text.first.content if text.present?
  end

  def build_path(parent_path, label)
    "#{parent_path}/#{label}"
  end

  def extract_subject(node)
    node.attribute_with_ns('about', NAMESPACE_HASH[:rdf]).value
  end

  def extract_subnodes(node)
    subject = extract_subject node
    @xml.xpath subnode_path(subject)
  end

  def subnode_path(subject)
    @subnode_path_template % subject
  end
end
