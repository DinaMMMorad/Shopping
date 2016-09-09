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
end
