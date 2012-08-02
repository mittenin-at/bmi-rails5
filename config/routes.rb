Bmi::Application.routes.draw do
  resources :invitations

  resources :weighings do
    collection do
      get 'diagram'
      get 'select_competitor'
      post 'compare'
    end
  end

  match '/signup/:invitation_token' => 'users#new', :as => :signup
 
  match 'authentication/login', :controller => 'authentication', :action => 'login'
  get "authentication/logout"
  post "invitations/create"

  resources :users

  root :to => "authentication", :action => "login"

# damit wird /login umgeleitet:
  match '/login', :controller  => "authentication", :action => "login"
  match '/logout', :controller => "authentication", :action => "logout"
end