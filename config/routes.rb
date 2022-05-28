Rails.application.routes.draw do
  get 'relationships/followed'
  get 'relationships/follows'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'users', to: 'users/registrations#create'
  end

  root to: "wine_articles#index"

  resources :wine_articles do
    resources :comments, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :our_owns, only: :show

end
