Opensourceforwomen::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations" }

  # get '/auth/:provider/callback' => "sessions#create"
  # get '/sign_out' => "sessions#destroy", :as => 'sign_out'

  # Static content
  get '/about' => "home#about", :as => 'about'
  get '/support' => "home#support", :as => 'support'
  get '/be-an-ally' => "home#allies", :as => 'allies'
  get '/thank-you' => "home#thank_you", :as => 'thank_you'

  root :to => 'home#index'

  resources :subscriptions

end
