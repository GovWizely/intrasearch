require 'user'

module Admin
  class GetUserAPI < Grape::API
    params do
      requires :id, allow_blank: false
    end

    get '/users/:id' do
      user = User.find_by_id params.id
      user ? user : status(:not_found)
    end
  end
end
