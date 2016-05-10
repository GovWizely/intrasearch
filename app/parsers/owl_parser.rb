module OwlParser
  NAMESPACE_HASH = {
    owl: 'http://www.w3.org/2002/07/owl#',
    rdf: 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
    rdfs: 'http://www.w3.org/2000/01/rdf-schema#' }.freeze

  def self.included(base)
    class << base
      attr_accessor :subnode_path_template
    end
  end

  def initialize(xml, max_depth = nil)
    @max_depth = max_depth
    @xml = xml
  end

  def subnodes(root_label, starting_path = nil)
    root_node = extract_root_node root_label
    Enumerator.new do |y|
      process_subnodes y,
                       extract_node_hash(root_node).merge(path: starting_path),
                       0
    end
  end

  protected

  def extract_root_node(root_label)
    @xml.xpath("//owl:Class[rdfs:label[.='#{root_label}']]", NAMESPACE_HASH).first
  end

  def process_subnodes(yielder, node_hash, depth)
    node_hash[:subnodes].each do |subnode|
      subnode_hash = extract_node_hash subnode, node_hash[:path]
      yielder << subnode_hash.except(:subnodes, :subject)

      depth += 1
      process_subnodes(yielder, subnode_hash, depth) if within_max_depth?(depth)
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
    @xml.xpath subnode_path(subject), NAMESPACE_HASH
  end

  def subnode_path(subject)
    self.class.subnode_path_template % template_format_args(subject)
  end

  def template_format_args(subject)
    subject
  end

  def within_max_depth?(current_depth)
    @max_depth.nil? || current_depth < @max_depth
  end
end
