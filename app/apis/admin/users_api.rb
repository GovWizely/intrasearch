require 'admin/create_user_api'
require 'admin/get_user_api'
require 'admin/get_users_api'
require 'admin/update_user_api'

module Admin
  class UsersAPI < Grape::API
    prefix :admin

    mount CreateUserAPI
    mount GetUsersAPI
    mount GetUserAPI
    mount UpdateUserAPI
  end
end
