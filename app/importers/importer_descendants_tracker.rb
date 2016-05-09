module ImporterDescendantsTracker
  def self.extended(base)
    base.module_eval do
      @descendants = []
    end

    class << base
      attr_reader :descendants
    end

    base.extend ModuleMethods
  end

  module ModuleMethods
    def track_descendant(descendant)
      @descendants |= [descendant]
    end
  end
end
