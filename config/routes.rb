Eatloco::Application.routes.draw do


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :dishes
  resources :attachments
  resources :menus, only: [:index]
  resources :orders
end