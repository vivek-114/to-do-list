class ListsController < ApplicationController

    def create
        if params[:email].present?
            user = User.find_by(email: params[:email])
            list = List.create!(title: params[:title], description: params[:description], user_id: user.id) if (params[:title].present? && params[:description].present? && user.present?)
        end
    end

    def index
    end

    def show
        lists = nil
        if session[:user_id].present?
            user = User.find(session[:user_id])
            if user.role == "super_admin"
                lists = List.all
            else
                lists = user.lists
                # lists = user.lists.permit(:title, :description, :created_at, :updated_at)
            end
        end
        render json: lists
    end
end