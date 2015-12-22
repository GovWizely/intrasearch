require 'active_support/core_ext/class/attribute'

require 'index_manager'

class BaseImporter
  class_attribute :model_class

  def import
    IndexManager.new(model_class).setup_new_index! do
      yield if block_given?
    end
  end
end
