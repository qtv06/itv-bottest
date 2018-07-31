Rails.application.routes.draw do
  get 'static_page/home'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :test_suits
  resources :users

  root "users#index"
end
