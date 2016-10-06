module UpdateExtraAttributesAPI
  def self.extended(base)
    base.class_eval do
      params do
        requires :id, allow_blank: false
        requires :html_description, :md_description
      end

      finder_module = base.name.demodulize.sub(/UpdateAPI\Z/, '').constantize
      patch "/#{finder_module.name.tableize}/:id" do
        declared_params = declared(params)
        model = finder_module.find_by_id declared_params.id

        if model
          model.update_extra_attributes declared_params.except(:id)
          body false
        else
          status :not_found
        end
      end
    end
  end
end
