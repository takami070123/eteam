Rails.application.routes.draw do
  root "home#index"

  # ゲーム関連
  get  "start",       to: "games#start"
  get  "game",        to: "games#index"
  post "game/start",  to: "games#start_game"
  post "check",       to: "games#check"
  post "finish",      to: "games#finish"
  get  "result",      to: "games#result"

  # 週間ランキング
  get "ranking", to: "play_logs#index"
  resources :play_logs, only: [:index]

  # ユーザー関連
  resources :users, only: [:new, :create, :destroy]

  # ログイン関連
  get    "login",  to: "sessions#new"
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
