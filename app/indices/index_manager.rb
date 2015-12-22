require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/time'
require 'elasticsearch'

require 'base_model'

class IndexManager
  def self.setup_indices
    BaseModel.model_classes.each do |klass|
      self.new(klass).setup_new_index_when_missing
    end
  end

  def initialize(model_class)
    @model_class = model_class
    @client = Elasticsearch::Client.new
  end

  def setup_new_index!
    current_index_names = get_current_index_names
    index_name_fragments = Array.new @model_class.index_name_fragments
    index_name = create_new_index! index_name_fragments
    yield if block_given?
    swap_indices current_index_names, index_name
    @model_class.reset_index_name!
    @model_class.gateway.refresh_index!
  end

  def setup_new_index_when_missing
    current_index_names = get_current_index_names
    setup_new_index! if current_index_names.empty?
  end

  def swap_indices(current_index_names, index_name)
    actions = []
    current_index_names.each do |current_index_name|
      actions << { remove: { index: current_index_name, alias: @model_class.default_index_name } }
    end
    actions << { add: { index: index_name, alias: @model_class.default_index_name }}
    @client.indices.update_aliases body: { actions: actions }
    @client.indices.delete index: current_index_names if current_index_names.present?
  end

  def create_new_index!(index_name_fragments)
    index_name = build_timestamped_index_name index_name_fragments
    @model_class.index_name = index_name
    @model_class.create_index!
    index_name
  end

  def get_current_index_names
    existing_index_names = []
    if @client.indices.exists_alias? name: @model_class.default_index_name
      existing_index_names = @client.indices.get_alias(name: @model_class.default_index_name).keys
    end
    existing_index_names
  end

  private

  def build_timestamped_index_name(namespace_fragments)
    index_name_fragments = Array.new namespace_fragments
    index_name_fragments.pop
    index_name_fragments.push DateTime.current.strftime('%Y%m%d_%H%M%S_%L')
    index_name_fragments.join('-')
  end
end
