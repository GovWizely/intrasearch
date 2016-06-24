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
      u = User.create declared(params, include_missing: false)
      u.persisted? ? u : status(:bad_request)
    end
  end
end
