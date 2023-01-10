Rails.application.routes.draw do
  get 'etrobocons/index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: "toppage#index"
  resources :manuals, only: [:index]
  resources :about, only: [:index]
  resources :etrobocons, only: [:index]
  resources :users, only: [:index] do
    resources :words, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :exchanged_words, only: [:index, :new, :create, :show] do
      resources :good_reputations, only: [:create]
      resources :bad_reputations, only: [:create]
    end
    resources :profiles, only: [:index]
  end
end