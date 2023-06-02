Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :users

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  delete "logout_user", to: "sessions#destroy"

  resources :tasks



end
