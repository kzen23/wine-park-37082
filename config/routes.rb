Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'users', to: 'users/registrations#create'
  end

  root to: "wine_articles#index"

  resources :wine_articles do
    resources :comments, only: [:new, :create, :edit, :update, :destroy]
    resources :favorites, only: [:create, :destroy]
  end

  resources :our_owns, only: :show

  resources :users do
    resources :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: "followings"
    get 'followers' => 'relationships#followers', as: "followers"
  end

end
