Rails.application.routes.draw do
  resources :ratings, only: [:index, :show, :create, :destroy]
  resources :music_fans
  resources :albums
end
