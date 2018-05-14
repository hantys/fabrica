Rails.application.routes.draw do
  resources :providers
  resources :clients
  resources :employees
  resources :stock_raw_materials
  resources :stock_final_products
  resources :compositions
  resources :raw_materials
  devise_for :users, :controllers => { :registrations => 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  root to: "home#index"
end
