Rails.application.routes.draw do
  resources :delivery_options
  resources :type_of_payments
  devise_for :users, controllers: { :registrations => 'registrations' }
  resources :products
  resources :budgets
  resources :hits
  resources :providers
  resources :clients
  resources :employees
  resources :stock_raw_materials, except: [:edit, :update]
  resources :stock_final_products
  resources :compositions
  resources :raw_materials

  get '/busca/endereco/:cep' => "home#find_by_address"

  get '/orcamento/pdf/:id' => "budgets#budget_pdf", as: :budget_pdf

  get '/load_hit_items/:composition' => "hits#load_items"
  get '/find_product/:id' => "budgets#find_product"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  root to: "home#index"
end
