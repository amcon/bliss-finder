Rails.application.routes.draw do
  resources :profiles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "profiles#new"

  get :terms, to: 'static#terms'

end
