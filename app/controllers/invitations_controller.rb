class InvitationsController < ApplicationController
  skip_filter :authorize
  
  def new
    @invitation = Invitation.new
  end

  def create    
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = User.find(session[:user_id]) if session[:user_id]
    if @invitation.save
      if User.find(session[:user_id])
        Mailer.deliver_invitation(@invitation, signup_url(@invitation.token))
        flash[:notice] = "Ihre Einladung wurde gesendet."
      else
        flash[:notice] = "Sie werden benachrichtigt, wenn die beta-Phase beendet ist."
      end
    end
    redirect_to root_url
  end
end

