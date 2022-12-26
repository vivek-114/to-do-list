class UsersController < ApplicationController
    def create
        user = User.create!(
            email: params[:email],
            password: params[:password],
            password_confirmation: params[:password_confirmation]
            )
        if user.present?
            session[:user_id] = user.id
            @current_user = user
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

    def show
        users = User.all
        render json: users
    end

    def login
        user = User.find_by(email: params["email"]).try(:authenticate, params["password"])
        if user.present?
            session[:user_id] = user.id
            @current_user = user
            render json: {
                status: "LoggedIn",
                user: user
            }
        else
            render json: {
                status: "Failed"
            }
        end
    end

end