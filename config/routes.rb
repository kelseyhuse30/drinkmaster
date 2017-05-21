Rails.application.routes.draw do
  get 'static/welcome'

  devise_for :users
  resources :cocktails
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "static#welcome"

end
