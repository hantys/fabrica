Rails.application.routes.draw do
  resources :budgets
  resources :budget_items
  resources :hits
  resources :providers
  resources :clients
  resources :employees
  resources :stock_raw_materials, except: [:edit, :update]
  resources :stock_final_products
  resources :compositions
  resources :raw_materials
  devise_for :users, :controllers => { :registrations => 'registrations' }

  get 'load_hit_items/:composition' => "hits#load_items"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  root to: "home#index"
end
