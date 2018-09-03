Rails.application.routes.draw do
  resources :category_products
  resources :bill_receivables
  resources :bill_payables
  resources :provider_contracts
  resources :banks
  resources :cred_cards
  resources :revenues
  resources :categories
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

  # contas a receber
  put '/contas_a_receber/item/receber/:item_id', to: 'bill_receivables#receive_item_update', as: :receive_item_update
  get '/contas_a_receber/item/receber/:item_id', to: 'bill_receivables#receive_item', as: :receive_item

  post '/contas_a_receber/receber_itens', to: 'bill_receivables#receives', as: :receives
  put '/contas_a_receber/receber_itens', to: 'bill_receivables#receives_update', as: :receives_update

  # contas a pagar
  put '/contas_a_pagar/item/pagar/:item_id', to: 'bill_payables#pay_item_update', as: :pay_item_update
  get '/contas_a_pagar/item/pagar/:item_id', to: 'bill_payables#pay_item', as: :pay_item

  post '/contas_a_pagar/paga_itens', to: 'bill_payables#pays', as: :pays
  put '/contas_a_pagar/paga_itens', to: 'bill_payables#pays_update', as: :pays_update

  get "/product/cod/:cod", to: 'products#product_cod', as: :product_cod

  put '/reserve_product/:id' => 'budgets#updated_reserve_product', as: :reserve_product

  get '/reserve_all_budget/:id' => 'budgets#reserve_all_budget', as: :reserve_all_budget

  scope '/relatorio' do
    get '/producao-diaria' => "reports#daily_production", as: :daily_production
  end

  scope '/busca' do
    get '/endereco/:cep', to: "home#find_by_address"
    get '/cidades/:id', to: "home#find_city"
    get '/sub-item-entrega/:id', to: "home#find_delivery"
    get '/sub-item-pagamento/:id', to: "home#find_payment"
    get '/batida/:id', to: "home#find_hit"
    get '/produto-primitivo/:id', to: "home#produto_primitivo"
  end

  scope '/pedido' do
    get '/reserve_product/:id', to: "budgets#reserve_product"
    get '/pdf/:id', to: "budgets#budget_pdf", as: :budget_pdf
    get '/orderm-de-servico/:id', to: "budgets#order_service", as: :order_service
    get '/atualiza-status/:id/:status', to: "budgets#update_status", as: :budget_update_status
    post '/atualiza-status/', to: "budgets#update_status", as: :budget_update_status_obs
  end

  get '/load_hit_items/:composition', to: "hits#load_items"
  get '/find_product/:id', to: "budgets#find_product"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  root to: "home#index"
end
