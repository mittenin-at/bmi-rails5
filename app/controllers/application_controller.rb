class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authorize, :except => [:login, :imprint, :privacy, :trigger_exception_notification]
  protect_from_forgery

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def trigger_exception_notification
    raise "I want to see an exception notification email."
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
