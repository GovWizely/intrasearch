require 'user'

module Admin
  class UpdateUserAPI < Grape::API
    params do
      requires :id, allow_blank: false

      optional :email
      optional :encrypted_password
      optional :reset_password_token
      optional :reset_password_sent_at, type: DateTime

      optional :remember_created_at, type: DateTime

      optional :sign_in_count, type: Integer
      optional :current_sign_in_at, type: DateTime
      optional :last_sign_in_at, type: DateTime
      optional :current_sign_in_ip
      optional :last_sign_in_ip

      optional :failed_attempts, type: Integer
      optional :unlock_token
      optional :locked_at, type: DateTime
    end

    patch '/users/:id' do
      declared_params = declared(params, include_missing: false)
      user = User.find_by_id declared_params[:id]

      if user
        user.attributes = declared_params.except(:id)
        if user.save
          body false
        else
          status :unprocessable_entity
          { errors: user.errors }
        end
      else
        status :not_found
      end
    end
  end
end
