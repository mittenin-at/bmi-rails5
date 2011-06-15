# encoding: utf-8

class AuthenticationController < ApplicationController
	
  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:email], params[:password])
      if user
        session[:user_id] = user.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || {:action => "index"})
      else
        flash.now[:notice] = "Ungültige Benutzername / Passwort - Kombination"
      end
    end
  end

  def logout
    session[:user_id] = nil    
    redirect_to(:controller => :admin, :action => :login)
  end

end
