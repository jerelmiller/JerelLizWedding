Wedding::Application.routes.draw do

  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  resources :sessions, only: :create


  root to: 'home#index'

  namespace :admin do
    resource :users, only: [:edit, :update]
    resources :images, except: [:edit, :show]
    root :to => 'admin#index'
  end

  end
