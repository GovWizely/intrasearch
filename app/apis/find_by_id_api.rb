module FindByIdAPI
  def self.extended(base)
    base.class_eval do
      search_module = base.name.demodulize.sub(/FindByIdAPI\Z/, '').constantize

      params do
        requires :id, allow_blank: false
      end

      get "/#{search_module.name.tableize}/:id" do
        model = search_module.find_by_id params[:id]
        model ? serializer.serialize(model) : status(:not_found)
      end
    end
  end
end
