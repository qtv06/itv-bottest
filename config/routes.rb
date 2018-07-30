Rails.application.routes.draw do
  resources :test_suits
  resources :users
  get 'static_page/home'
  root "users#index"
end
