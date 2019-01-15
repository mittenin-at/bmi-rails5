Rails.application.routes.draw do
  resources :invitations do
    member do
      get 'mail'
    end
  end

  resources :weighings do
    collection do
      get 'diagram'
      get 'select_competitor'
      post 'compare'
    end
  end

  get '/signup/:invitation_token' => 'users#new', :as => :signup

  post 'authentication/login', :controller => 'authentication', :action => 'login'
  get "authentication/logout"
  post "invitations/create"

  resources :users

  root :to => "authentication", :action => "login"

  post '/login', :controller  => "authentication", :action => "login"
  get '/logout', :controller => "authentication", :action => "logout"

  get '/datenschutz', :controller => "authentication", :action => "privacy"
  get '/impressum', :controller => "authentication", :action => "imprint"
end