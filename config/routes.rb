Rails.application.routes.draw do
  resources :mangas
  # Devise routes for users
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  # Static page for confirmation instructions
  get '/confirmation_instructions', to: 'static_pages#confirmation_instructions', as: :confirmation_instructions

  # Homepage accessible to everyone
  root to: 'home#index'

  # Admin area with proper namespace
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    get 'users/:id/edit', to: 'dashboard#edit_user', as: 'edit_user'
    patch 'users/:id', to: 'dashboard#update_user', as: 'update_user'
    delete 'users/:id', to: 'dashboard#delete_user', as: 'delete_user'
  end

  # Member area
  namespace :member do
    get 'dashboard', to: 'dashboard#index'
  end

  resources :mangas
end
