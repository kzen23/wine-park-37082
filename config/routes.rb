Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'users', to: 'users/registrations#create'
  end
  root to: "wine_articles#index"
  resources :wine_articles, only: :index
end
