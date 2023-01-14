Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post "/auth/:provider/callback", to: "sessions#create"
  get "/auth/:provider/callback", to: "sessions#create"
  root "static_pages#root"
end
