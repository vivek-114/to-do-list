class ListsController < ApplicationController

    def create
        list = List.create!(title: params[:title], description: params[:description]) if (params[:title].present? && params[:description].present?)
    end

    def index
    end

    def show
        lists = List.all
        render json: lists
    end
end