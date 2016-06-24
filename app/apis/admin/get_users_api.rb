require 'trade_event'

module Admin
  class GetUsersAPI < Grape::API
    params do
      optional :email, allow_blank: false
      optional :reset_password_token, allow_blank: false
      optional :unlock_token, allow_blank: false
    end

    get '/users' do
      User.where declared(params, include_missing: false)
    end
  end
end
