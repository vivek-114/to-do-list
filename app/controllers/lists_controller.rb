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
        lists = List.all
        render json: lists
    end
end