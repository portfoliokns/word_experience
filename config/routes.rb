Rails.application.routes.draw do
  devise_for :users
  root to: "toppage#index"
  resources :manuals, only: [:index]
  resources :users, only: [:index] do
    resources :words, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :exchanged_words, only: [:index, :new, :create, :show] do
      resources :good_reputations, only: [:create]
    end
  end
end