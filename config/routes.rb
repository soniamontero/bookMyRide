Rails.application.routes.draw do
  devise_for :users
  resources :rides do
    resources :bookings
  end
end
