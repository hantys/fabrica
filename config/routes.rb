Rails.application.routes.draw do
  resources :compositions
  resources :raw_materials
  devise_for :users, :controllers => { :registrations => 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  get '/render/compositionals_or_compositions/:kind' => "compositions#compositionals_or_compositions", as: :compositionals_or_compositions
  root to: "home#index"
end
