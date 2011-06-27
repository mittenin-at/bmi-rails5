Bmi::Application.routes.draw do
  resources :invitations

  resources :weighings do
    collection do
      get 'diagram'
    end
  end

  match '/signup/:invitation_token' => 'users#new', :as => :signup
 
  match 'authentication/login', :controller => 'authentication', :action => 'login'
  get "authentication/logout"
  post "invitations/create"

  resources :users

  root :to => "weighings", :action => "index"

# damit wird /login umgeleitet:
  match '/login' => redirect("/authentication/login")
  match '/logout' => redirect("/authentication/logout")

# und nun noch sonstiger mist auf die Startseite:
  match '*path' => redirect("/")

end

