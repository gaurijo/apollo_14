Rails.application.routes.draw do
  resources :astronauts, only: [:index]
end
