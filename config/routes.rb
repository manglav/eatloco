Eatloco::Application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :dishes
  resources :attachments
  resources :menus, only: [:index]
  resources :original_orders
  resources :counter_orders
end