Rails.application.routes.draw do
  get 'test_scripts/create'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :test_suits do
    resources :test_cases
  end
  resources :users

  root "test_suits#index"
end
