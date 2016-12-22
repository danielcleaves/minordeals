Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'

  resources :users, only: [:show]
  resources :services


  resources :services do
  	resources :orders, only: [:create]
  end

  resources :services do
    resources :reviews, only: [:create, :destroy]
  end

  resources :order, only: [:show]
  resources :charges

  get '/user_orders' => 'orders#user_orders'
  get '/user_sales' => 'orders#user_sales'

  get '/search', to: 'search#search'
end
