Rails.application.routes.draw do
  devise_for :users
  root to: 'lists#index'
  resources :lists, only: %i[show new index create destroy] do
    resources :bookmarks, only: %i[new index create]
    resources :reviews, only: %i[create index new]
  end
  resources :bookmarks, only: :destroy
  resources :reviews, only: :destroy
end
