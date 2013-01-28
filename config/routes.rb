Wedding::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  resources :sessions, only: :create


  root to: 'home#index'
  get 'blog' => 'home#blog', as: 'blog'
  get 'our-story' => 'home#our_story', as: 'our_story'

  namespace :admin do
    resource :users, only: [:edit, :update]
    resources :images, except: [:edit, :show]
    resources :blogs
    root :to => 'admin#index'
  end

  end
