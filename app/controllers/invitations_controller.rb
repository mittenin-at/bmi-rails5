class InvitationsController < ApplicationController
  skip_filter :authorize
  
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = User.find_by_id(session[:user_id])
    debugger
    if @invitation.save
      if User.find_by_id(session[:user_id])
        Mailer.deliver_invitation(@invitation, signup_url(@invitation.token))
        flash[:notice] = "Ihre Einladung wurde gesendet."
        redirect_to root_path
      else
        flash[:notice] = "Sie werden benachrichtigt, wenn die beta-Phase beendet ist."
        redirect_to authentication_login_path
      end
    else
      flash[:notice] = "Ihre E-Mailadresse ist dem System bereits bekannt."
      redirect_to authentication_login_path
    end
  end
end

