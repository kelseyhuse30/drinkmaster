Rails.application.routes.draw do
	root to: "static#welcome"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :cocktails, :ingredients

  resources :users, only: [:show] do
  	resources :cocktails, only: [:index]
  end

  resources :cocktails, only: [:show] do
  	resources :ingredients, only: [:index, :new, :create]
  end

  get '/mocktails' => 'cocktails#mocktails'
  get '/ordered' => 'cocktails#ordered'

end
