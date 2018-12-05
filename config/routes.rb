Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'

  resources :rides do
    resources :bookings
    resources :reviews, only: [:new, :create]
  end
end
