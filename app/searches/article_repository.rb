require 'elasticsearch/persistence'

class ArticleRepository < Elasticsearch::Persistence::Repository::Class
  def initialize(options = {})
    self.index_name = options[:types].map(&:index_name).join(',')
    self.document_type = options[:types].map(&:document_type).join(',')
  end

  def deserialize(document)
    klass = __get_klass_from_type(document['_type'])
    object = klass.new document['_source']

    object.instance_variable_set :@_id, document['_id']
    object.instance_variable_set :@_index, document['_index']
    object.instance_variable_set :@_type, document['_type']
    object.instance_variable_set :@_version, document['_version']

    object.instance_variable_set :@hit,
                                 Hashie::Mash.new(document.except('_index', '_type', '_id', '_version', '_source'))

    object.instance_variable_set(:@persisted, true)
    object
  end
end
