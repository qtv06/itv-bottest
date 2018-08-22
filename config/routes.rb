Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  post "test_scripts/create"
  get "test_suits/get_test_case_change"
  get "/commit", to: "commits#commit"
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
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  root "test_suits#index"
end
