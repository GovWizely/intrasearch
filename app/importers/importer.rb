module Importer
  def self.extended(base)
    class << base
      attr_accessor :model_class
    end

    base.extend ModuleMethods
  end

  module ModuleMethods
    def import
      IndexManager.new(model_class).setup_new_index! do
        yield if block_given?
      end
    end
  end
end
