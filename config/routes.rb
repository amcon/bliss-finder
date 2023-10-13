Rails.application.routes.draw do
  resources :profiles do
    member do
      put :randomize, to: 'profiles#randomize'
      get :share_to_social, to: 'profiles#share_to_social'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "profiles#new"
  root "static#coming_soon"

  get :terms, to: 'static#terms'
  get :coming_soon, to: 'static#coming_soon'
  get :home, to: 'static#home'

end
