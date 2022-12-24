class UsersController < ApplicationController
    def create
        user = User.create!(
            email: params[:email],
            password: params[:password],
            password_confirmation: params[:password_confirmation]
            )
        if user.present?
            render json: {
                status: "Created",
                user: user
            }
        else
            render json: {
                status: "Failed"
            }
        end
    end
end