Opensourceforwomen::Application.routes.draw do

#  require 'sidekiq/web'

  # Static content
  get "/about" => "home#about", :as => "about"
  get "/be-an-ally" => "home#allies", :as => "allies"
  get "/code-of-conduct" => "home#code_of_conduct", :as => "code_of_conduct"
  get "/contact" => "contacts#new", :as => "contact_us"
  get "/support" => "home#support", :as => "support"
  get "/thank-you" => "home#thank_you", :as => "thank_you"

  # Session management
  get "/sign_up", to: "users#new", as: :sign_up
  get "/sign_in", to: "sessions#new", as: :sign_in
  get "/sign_out", to: "sessions#destroy", as: :sign_out

  # Mentoring and pairing
  get "/mentors", to: "mentors#index"
  get "/pair_partners", to: "pair_partners#index"

  # Users
  resources :users do
    resources :messages
    member do
      get :activate
    end
  end

  # Other
  resources :abuse_reports, only: [:new, :create]
  resources :bookmarks, only: [:create]
  resources :contacts, only: [:new, :create]
  resources :dashboards, only: [:show]
  resources :extended_profiles
  resources :invitations, only: [:new, :create]
  resources :password_resets
  resources :projects
  resources :project_comments, only: [:create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :subscriptions

#  mount Sidekiq::Web => '/jobs'

  # Admin
  namespace :admin do
    get "/admin", to: "admin#index", as: :admin_path
    resources :abuse_reports
    resources :abuse_report_comments
    resources :users do
      resources :messages
    end
  end

  root :to => "home#index"

end
