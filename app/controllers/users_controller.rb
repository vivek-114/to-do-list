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
            # flash[:success] = "User created Successfully!"
            render json: {
                status: "Created",
                user: user.email,
                role: user.role,
                flash: (session["flash"].present? &&  session["flash"]["flashes"].present?) ? {class: "success", message: "User created Successfully!"} : nil
            }
            session["flash"] = nil if session["flash"].present?
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
            # flash[:success] = "Logged in successfully"
            @current_user = user
            render json: {
                status: "LoggedIn",
                user: user.email,
                role: user.role,
                flash:  {class: "success", message: "Logged in Successfully"}
            }
            session["flash"] = nil if session["flash"].present?
        else
            render json: {
                status: "Failed"
            }
        end
    end

    def is_user_logged_in
        if session[:user_id].present?
            user = User.find(session[:user_id])
            # binding.pry
            if user.present?
                @current_user = user
                render json: {
                    status: "LoggedIn",
                    user: user.email,
                    role: user.role,
                    flash: (session["flash"].present? &&  session["flash"]["flashes"].present?) ? {class: (session["flash"]["flashes"]).keys.first, message: (session["flash"]["flashes"]).values.first} : nil
                }
                session["flash"] = nil if session["flash"].present?
            else
                render json: {
                    status: "Failed"
                }
            end
        else
            render json: {
                status: "Failed"
            }
        end
    end

    def clear_session
        reset_session
        session.delete("user_id")
        session["user_id"] = nil
        session.clear
        render json: {
            status: "Success"
        }
    end

    def edit

    end

end