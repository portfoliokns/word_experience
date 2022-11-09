Rails.application.routes.draw do
  devise_for :users
  root to: "toppage#index"
  resources :users, only: [:index] do
    resources :words, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end