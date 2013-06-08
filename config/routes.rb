DiplomacyTurns::Application.routes.draw do
  resources :turns

  get  "/admin"       => "admin#index",       :as => "admin"
  post "/start_game"  => "admin#start_game",  :as => "start_game"
  get  "/config_game" => "admin#config_game", :as => "config_game"
  get  "/next_round"  => "admin#next_round",  :as => "next_round"
  get  "/defeat"      => "admin#defeat",      :as => "defeat"

  get "/current_round" => "round#index",      :as => "current_round"
  devise_for :users
  get "/home" => "user#home"
  root :to => "turns#index"
end
