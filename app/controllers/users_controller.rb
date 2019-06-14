class UsersController < ApplicationController

    before_action :set_user, only: [:show, :purchase_history]
    skip_before_action :authorize_request, only: :create

    def create
        user = User.create!(user_params)
        auth_token = AuthenticateUser.new(user.email, user.password).perform
        response = { message: Message.account_created, auth_token: auth_token }
        json_response(response, :created)
    end

    def show
        json_response(@user)
    end

    def purchase_history
        # TODO Only view user's history
        json_response(@user.purchase_history)
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

    def set_user
        @user = User.find_by_username!(params[:username])
    end
end
