Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  apipie

  devise_for :users, except: [:update], controllers: {
      :registrations => 'users/registrations',
      :sessions => 'users/sessions',
      :passwords => 'users/passwords'
  }

  get '/products/new' => 'products#new_arrivals'
  get '/products' => 'products#category_products'
  get '/categories' => 'categories#index'
  get '/get_products' => 'products#get_products_by_ids'
  get '/today_notifications' => 'notifications#get_today_notifications'
  get '/search_product' => 'products#search_product'

  delete '/devices/destroy_with_reg_id' => 'devices#destroy_with_reg_id'
  # post '/create_orders' => 'orders#create_orders'
  resources :orders, only: [:create]
  resources :devices, only: [:create]

  root 'admin/products#index'
end
