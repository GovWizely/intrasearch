require 'active_support/core_ext/object/blank'
require 'nokogiri'
require 'uri'

class OwlParser
  NAMESPACE_HASH = {
    owl: 'http://www.w3.org/2002/07/owl#',
    rdf: 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
    rdfs: 'http://www.w3.org/2000/01/rdf-schema#' }.freeze

  def initialize(file:, id_prefix:, max_depth: nil, root_label:)
    @id_prefix = id_prefix
    @max_depth = max_depth
    @root_label = root_label
    @xml = Nokogiri::XML file
  end

  def each_class(&block)
    root_node = extract_root_node
    process_subclass_nodes extract_node_hash(root_node).merge(path: nil),
                           &block
  end

  private

  def extract_root_node
    @xml.xpath("//owl:Class[rdfs:label[.='#{@root_label}']]", NAMESPACE_HASH).first
  end

  def process_subclass_nodes(node_hash, current_depth = 1, &block)
    node_hash[:subclass_nodes].each do |child_node|
      next if @max_depth && current_depth > @max_depth
      child_node_hash = extract_node_hash child_node, node_hash[:path]
      yield child_node_hash.except(:subclass_nodes, :subject)

      process_subclass_nodes child_node_hash, (current_depth + 1), &block
    end
  end

  def extract_node_hash(node, parent_path = nil)
    label = extract_label node
    path = build_path parent_path, label
    subject = extract_subject node
    id = build_id subject
    subclass_nodes = extract_subclass_nodes node

    { id: id,
      label: label,
      leaf_node: subclass_nodes.blank?,
      path: path,
      subclass_nodes: subclass_nodes,
      subject: subject }
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

  def build_id(subject)
    sanitized_subject = URI.parse(subject).path.tr('/', '')
    "#{@id_prefix}-#{sanitized_subject}"
  end

  def extract_subclass_nodes(node)
    subject = extract_subject node
    @xml.xpath "//owl:Class[rdfs:subClassOf[@rdf:resource='#{subject}']]"
  end
end

