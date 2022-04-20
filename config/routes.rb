Rails.application.routes.draw do
  devise_for :users
  root to: "wine_articles#index"
end
