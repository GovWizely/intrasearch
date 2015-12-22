module Subclassable
  def self.extended(base)
    base.class_eval do
      class_attribute :subclasses, instance_writer: false
      self.subclasses = []
    end
  end

  def inherited(subclass)
    self.subclasses |= [subclass]
  end
end
