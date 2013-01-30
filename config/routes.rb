Wedding::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  resources :sessions, only: :create


  root to: 'home#index'
  get 'our-story' => 'home#our_story', as: 'our_story'
  resources :blogs, only: [:index, :show]

  namespace :admin do
    resource :users, only: [:edit, :update]
    resources :images, except: [:edit, :show]
    resources :blogs
    root :to => 'admin#index'
  end

  end
