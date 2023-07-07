Rails.application.routes.draw do
  get 'etrobocons/index'
  resources :devicefingerprinting, only: [:index]
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: "toppage#index"
  resources :inquiries, only: [:new, :create]
  post 'inquiries/confirm', to: 'inquiries#confirm', as: 'confirm_inquiry'
  post 'inquiries/back', to: 'inquiries#back', as: 'back_inquiry'
  get 'inquiries/send', to: 'inquiries#send', as: 'send_inquiry'
  resources :manuals, only: [:index]
  resources :about, only: [:index]
  resources :etrobocons, only: [:index]
  resources :typing, only: [:index]
  resources :users, only: [:index] do
    resources :words, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :exchanged_words, only: [:index, :new, :create, :show] do
      resources :good_reputations, only: [:create]
      resources :bad_reputations, only: [:create]
    end
    resources :profiles, only: [:index]
  end
end