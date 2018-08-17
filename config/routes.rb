Rails.application.routes.draw do
  post "test_scripts/create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :test_suits do
    collection do
      post "duplicate"
    end
    resources :test_cases
  end
  resources :users

  root "test_suits#index"
end
