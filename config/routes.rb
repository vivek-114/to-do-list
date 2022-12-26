Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root "dasboard#index"
  resource :dashboard, only: [:index]
  get :index, to: 'lists#index'
  resource :lists
  resource :users
  post :login, to: 'users#login'
end
