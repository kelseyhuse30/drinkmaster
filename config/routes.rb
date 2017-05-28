Rails.application.routes.draw do
  get 'static/welcome'

  devise_for :users
  resources :cocktails do
  	resources :ingredients, only: [:show, :index, :new]
  end

  resources :ingredients
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "static#welcome"

  get '/auth/facebook/callback' => 'sessions#omnicreate'

end
