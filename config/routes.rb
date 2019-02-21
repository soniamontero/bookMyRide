Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'

  resources :rides do
    resources :bookings
    resources :reviews, only: [:new, :create]
  end

  resources :users, only: [:edit, :show, :update]
  get "/profile", to: "users#show", as: :profile
  get "/dashboard", to: "pages#user_dashboard", as: :dashboard
  get "/rental_dashboard", to: "pages#rental_dashboard", as: :rental_dashboard

  resources :conversations do
    resources :messages
  end
end
