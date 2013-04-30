DiplomacyTurns::Application.routes.draw do
  resources :turns


  devise_for :users
  get "/home" => "user#home"
  root :to => "user#home"
end
