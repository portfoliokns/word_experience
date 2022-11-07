Rails.application.routes.draw do
  get 'words/index'
  get 'words/new'
  devise_for :users
  root to: "toppage#index"
  resources :words, only: [:index, :new]
end
