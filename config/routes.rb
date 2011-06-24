Bmi::Application.routes.draw do
  resources :weighings do
    collection do
      get 'diagram'
    end
  end

  match 'authentication/login', :controller => 'authentication', :action => 'login'
  get "authentication/logout"

  resources :users

  root :to => "weighings", :action => "index"

# damit wird /login umgeleitet:
  match '/login' => redirect("/authentication/login")
  match '/logout' => redirect("/authentication/logout")

# und nun noch sonstiger mist auf die Startseite:
  match '*path' => redirect("/")

end

