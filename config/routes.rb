Rails.application.routes.draw do
  get 'static/welcome'

  devise_for :users
  resources :cocktails, :ingredients

  resources :users, only: [:show] do
  	resources :cocktails, only: [:index]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "static#welcome"

  get '/auth/facebook/callback' => 'sessions#omnicreate'

  get '/mocktails' => 'cocktails#mocktails'

end
