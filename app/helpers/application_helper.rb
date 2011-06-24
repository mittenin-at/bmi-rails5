module ApplicationHelper
  def admin?
    User.find_by_id(session[:user_id]).admin?
  end
end

