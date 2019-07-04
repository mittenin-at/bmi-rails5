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

  post 'authentication/login', to: "authentication#login"
  get "authentication/logout"
  post "invitations/create"

  resources :users

  root :to => "authentication#login"

  post '/login', to: "authentication#login"
  get '/logout', to: "authentication#logout"

  get '/datenschutz', to: "authentication#privacy"
  get '/impressum', to: "authentication#imprint"
  get 'trigger_exception_notification', to: 'application#trigger_exception_notification'
end
