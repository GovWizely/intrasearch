require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/time'
require 'elasticsearch'

require 'base_model'

class IndexManager
  def self.setup_indices
    BaseModel.model_classes.each do |klass|
      new(klass).setup_new_index_when_missing
    end
  end

  def initialize(model_class)
    @model_class = model_class
    @client = Elasticsearch::Client.new
  end

  def setup_new_index!(index_name_prefix = nil, &block)
    current_index_names = get_current_index_names
    index_name_prefix ||= @model_class.index_name_prefix
    new_index_name = create_new_index! index_name_prefix

    exception = nil
    exception = execute_block(&block) if block_given?

    if exception
      @client.indices.delete index: new_index_name
      raise exception
    else
      swap_indices current_index_names, new_index_name
      @model_class.reset_index_name!
      @model_class.gateway.refresh_index!
    end
  end

  def setup_new_index_when_missing
    current_index_names = get_current_index_names(true)
    setup_new_index! if current_index_names.empty?
  end

  def swap_indices(current_index_names, index_name)
    actions = []
    current_index_names.each do |current_index_name|
      actions << { remove: { index: current_index_name, alias: @model_class.index_alias_name } }
    end
    actions << { add: { index: index_name, alias: @model_class.index_alias_name } }
    @client.indices.update_aliases body: { actions: actions }
    @client.indices.delete index: current_index_names if current_index_names.present?
  end

  def create_new_index!(index_name_prefix)
    new_index_name = build_timestamped_index_name index_name_prefix
    @model_class.index_name = new_index_name
    @model_class.create_index!
    @model_class.gateway.refresh_index!
    new_index_name
  end

  def get_current_index_names(verify_version = false)
    existing_index_names = []
    args = { name: @model_class.index_alias_name }
    args[:index] = [@model_class.index_name_prefix, '*'].join('-') if verify_version
    if @client.indices.exists_alias? args
      existing_index_names = @client.indices.get_alias(name: @model_class.index_alias_name).keys
    end
    existing_index_names
  end

  private

  def execute_block(&_block)
    yield
    nil
  rescue => e
    e
  end

  def build_timestamped_index_name(index_name_prefix)
    [index_name_prefix,
     DateTime.current.strftime('%Y%m%d_%H%M%S_%L')].join('-')
  end
end
