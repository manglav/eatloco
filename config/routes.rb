Eatloco::Application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users do
    resources :notifications, only: [:update]
  end
  resources :dishes
  resources :attachments
  resources :menus, only: [:index]
  resources :original_orders do
    resources :counter_orders, only: [:new, :create]
  end
  resources :counter_orders, except: [:new, :create]
end