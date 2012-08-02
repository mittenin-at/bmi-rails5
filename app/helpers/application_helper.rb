module ApplicationHelper
  def admin?
    if session[:user_id]
      User.find_by_id(session[:user_id]).admin?
    else 
      return false
    end
  end

  def current_user
    if session[:user_id]
      User.find_by_id(session[:user_id])
    else
      return false
    end
  end
end

