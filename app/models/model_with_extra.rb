module ModelWithExtra
  def self.included(base)
    base.class_eval do
      @extra_class = "#{parent.name}::Extra".constantize
    end

    class << base
      attr_reader :extra_class
    end
    base.include InstanceMethods
  end

  module InstanceMethods
    def update_extra_attributes(extra_attributes)
      @extra = self.class.extra_class.create extra_attributes.merge id: id
      @extra.persisted?
    end

    def extra
      load_extra unless @extra
      @extra
    end

    def description
      extra.html_description.present? ? extra.html_description : original_description
    end

    private

    def load_extra
      @extra = begin
        self.class.extra_class.find id
      rescue Elasticsearch::Persistence::Repository::DocumentNotFound
        self.class.extra_class.new
      end
    end
  end
end