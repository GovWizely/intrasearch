require 'user'

module Admin
  class CreateUserAPI < Grape::API
    params do
      requires :email, allow_blank: false
    end

    post '/users' do
      declared_params = declared params
      existing_users = User.where email: declared_params.email
      if existing_users.present?
        status :bad_request
      else
        user = User.create declared_params
        user.persisted? ? user : status(:bad_request)
      end
    end
  end
end
