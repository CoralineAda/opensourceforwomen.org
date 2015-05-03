Opensourceforwomen::Application.routes.draw do

  # Static content
  get '/about' => "home#about", :as => 'about'
  get '/support' => "home#support", :as => 'support'
  get '/be-an-ally' => "home#allies", :as => 'allies'
  get '/thank-you' => "home#thank_you", :as => 'thank_you'

  root :to => 'home#index'

  # Users
  resources :users, only: [:new, :create] do
    member do
      get :activate
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  get '/sign_up', to: 'users#new', as: :sign_up
  get '/sign_in', to: 'sessions#new', as: :sign_in
  delete '/sign_out', to: 'sessions#destroy', as: :sign_out

  # Other
  resources :subscriptions

end
