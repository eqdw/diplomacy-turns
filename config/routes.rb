DiplomacyTurns::Application.routes.draw do
  devise_for :users

  root :to => "user#home"
end
