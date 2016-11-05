Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  resources :relationships, only: [:create, :destroy]
  resources :categories, only: :show
  resources :users, only: [:index, :show, :edit, :update] do
    resources :books, only: [:index, :show, :new, :create, :destroy] do
      resources :impressions, only: [:create, :destroy]
    end
    resources :storages, only: [:create, :destroy]
    member do
      get :following, :followers
    end
  end
  resources :letters, only: [:index, :show, :create] do
    resources :comments, only: [:create, :destroy] do
      resources :likes, only: [:create, :destroy]
    end
  end
  root 'letters#index'
end
