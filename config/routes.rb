Rails.application.routes.draw do
  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  root 'pages#home'

  resources :rides do
    resources :bookings do
      resources :reviews, only: [:new, :create]
      resources :payments, only: [:new, :create]
    end
  end

  resources :users, only: [:edit, :show, :update]
  get '/profile', to: 'users#show', as: :profile
  get '/policy', to: 'pages#policy', as: :policy
  get '/dashboard', to: 'pages#user_dashboard', as: :dashboard
  get '/rental_dashboard', to: 'pages#rental_dashboard', as: :rental_dashboard

  resources :conversations do
    resources :messages
  end
end
