Opensourceforwomen::Application.routes.draw do

  # Static content
  get '/about' => "home#about", :as => 'about'
  get '/support' => "home#support", :as => 'support'
  get '/be-an-ally' => "home#allies", :as => 'allies'
  get '/thank-you' => "home#thank_you", :as => 'thank_you'
  get '/code-of-conduct' => "home#code_of_conduct", :as => "code_of_conduct"

  root :to => 'home#index'

  # Users
  resources :users do
    member do
      get :activate
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets

  # Session management
  get '/sign_up', to: 'users#new', as: :sign_up
  get '/sign_in', to: 'sessions#new', as: :sign_in
  get '/sign_out', to: 'sessions#destroy', as: :sign_out

  # Other
  resources :subscriptions

end
