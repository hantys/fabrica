Rails.application.routes.draw do
  devise_for :users, controllers: { :registrations => 'registrations' }

  # resources :out_of_stocks
  resources :delivery_options
  resources :type_of_payments
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

  put '/reserve_product/:id' => 'budgets#updated_reserve_product', as: :reserve_product

  scope '/relatorio' do
    get '/producao-diaria' => "reports#daily_production", as: :daily_production
  end

  scope '/busca' do
    get '/endereco/:cep' => "home#find_by_address"
    get '/cidades/:id' => "home#find_city"
    get '/sub-item-entrega/:id' => "home#find_delivery"
    get '/sub-item-pagamento/:id' => "home#find_payment"
    get '/batida/:id' => "home#find_hit"
    get '/produto-primitivo/:id' => "home#produto_primitivo"
  end

  scope '/busca' do
    get '/orcamento/reserve_product/:id' => "budgets#reserve_product"
    get '/orcamento/pdf/:id' => "budgets#budget_pdf", as: :budget_pdf
    get '/orcamento/atualiza-status/:id/:status' => "budgets#update_status", as: :budget_update_status
  end

  get '/load_hit_items/:composition' => "hits#load_items"
  get '/find_product/:id' => "budgets#find_product"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  root to: "home#index"
end
