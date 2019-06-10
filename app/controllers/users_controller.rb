class UsersController < ApplicationController

    skip_before_action :authorize_request, only: :create

    def create
        user = User.create!(user_params)
        auth_token = AuthenticateUser.new(user.email, user.password).perform
        response = { message: Message.account_created, auth_token: auth_token }
        json_response(response, :created)
    end

    def show
        user = User.find_by_username!(params[:username])
        json_response(user)
    end

    private

    def user_params
        params.permit(
            :username,
            :email,
            :password,
            :password_confirmation
        )
    end
end
