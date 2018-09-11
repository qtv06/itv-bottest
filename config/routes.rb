Rails.application.routes.draw do
  get 'layouts/index'
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
  resources :layouts
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  post "/edit/render_row_step", to: "test_cases#render_row_step", as: "render_row_step"
  post "/edit/add_row_step", to: "test_cases#add_row_step", as: "add_row_step"


  root "test_suits#index"
end
