Rails.application.routes.draw do
  root 'static_pages#home'

  get 'help' =>  'static_pages#help'
  get 'about' =>  'static_pages#about'
  get 'contact' =>  'static_pages#contact'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  namespace :api, { format: 'json' } do
    get 'login' => 'sessions#new'
    post 'login' => 'sessions#create'
    delete 'logout' => 'sessions#destroy'
  end

  resources :users do
    member do
      get :following, :followers
    end
  end

  namespace :api, { format: 'json' } do
    resources :users, only: [:index, :show, :create, :update, :destroy] do
      member do
        get :following, :followers
      end
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets, only:[:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy, :show]
  resources :relationships, only: [:create, :destroy]
end
