Rails.application.routes.draw do
  resources :vonages
  resources :rooms
  devise_for :users
  root "rooms#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
