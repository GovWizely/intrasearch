require 'user'

module Admin
  class CreateUserAPI < Grape::API
    params do
      requires :email, allow_blank: false
    end

    post '/users' do
      user = User.create declared(params)

      if user.persisted?
        user
      else
        status(:unprocessable_entity)
        { errors: user.errors }
      end
    end
  end
end
