class ApplicationController < ActionController::Base
protect_from_forgery
  before_filter :authorize, :except => [:login]

protected
  def authorize
    unless User.find_by_id(session[:user_id])
      session[:original_uri] = request.fullpath
      flash[:notice] ||= "Bitte anmelden!"
      redirect_to :controller => :authentication, :action => :login
    end
  end

  def admin_only
    unless User.find_by_id(session[:user_id]).admin?
      flash[:error] = "Dieser Aufruf ist nicht erlaubt."
      redirect_to :back
    end
    rescue ActionController::RedirectBackError
      redirect_to :root
  end
end

