Rails.application.routes.draw do
  root "home#index"
  get  "start", to: "games#start"
  get  "game", to: "games#index"
  post "game/start", to: "games#start_game"
  post "check", to: "games#check"
  get  "result", to: "games#result"
  get "ranking", to: "rankings#index"

  resources :users, only: [:new, :create, :destroy]
  
  get    "login",  to: "sessions#new"
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  post "finish", to: "games#finish"
  get  "result", to: "games#result"
end