Bmi::Application.routes.draw do
  resources :weighings
  
  match 'authentication/login', :controller => 'authentication', :action => 'login'
  get "authentication/logout"

  resources :users

  root :to => "weighings", :action => "index"

# damit wird /login umgeleitet:    
  match '/login' => redirect("/authentication/login")
  
# und nun noch sonstiger mist auf die Startseite: 
  match '*path' => redirect("/")
  
end
