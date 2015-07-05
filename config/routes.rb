Opensourceforwomen::Application.routes.draw do

  # Static content
  get '/about' => "home#about", :as => 'about'
  get '/be-an-ally' => "home#allies", :as => 'allies'
  get '/code-of-conduct' => "home#code_of_conduct", :as => "code_of_conduct"
  get '/contact' => 'contacts#new', :as => "contact_us"
  get '/support' => "home#support", :as => 'support'
  get '/thank-you' => "home#thank_you", :as => 'thank_you'

  # Session management
  get '/sign_up', to: 'users#new', as: :sign_up
  get '/sign_in', to: 'sessions#new', as: :sign_in
  get '/sign_out', to: 'sessions#destroy', as: :sign_out

  # Users
  resources :users do
    member do
      get :activate
      resources :messages
    end
  end

  # Other
  resources :bookmarks, only: [:create]
  resources :contacts, only: [:new, :create]
  resources :dashboards, only: [:show]
  resources :pair_profiles
  resources :password_resets
  resources :projects
  resources :sessions, only: [:new, :create, :destroy]
  resources :subscriptions

  root :to => 'home#index'

end
