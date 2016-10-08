Rails.application.routes.draw do
  resources :users, only: [:show, :edit, :update]
  resources :letters, only: [:index, :show, :new, :create] do
    resources :comments, only: [:create, :update, :destroy] do
      resources :likes, only: [:create, :destroy]
    end
  end
  root 'letters#index'
end
