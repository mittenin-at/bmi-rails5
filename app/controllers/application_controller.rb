class ApplicationController < ActionController::Base
before_filter :set_locale
before_filter :authorize, :except => [:login]
protect_from_forgery

def set_locale
  I18n.locale = params[:locale] || I18n.default_locale
end  

def default_url_options(options={})
  logger.debug "default_url_options is passed options: #{options.inspect}\n"
  { :locale => I18n.locale }
end

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

  def current_user
    if session[:user_id]
      User.find_by_id(session[:user_id])
    end
  end
end
