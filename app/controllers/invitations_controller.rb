class InvitationsController < ApplicationController
  before_filter :admin_only, :except => [:new, :create]
  skip_filter :authorize, :only => [:new, :create]

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = User.find_by_id(session[:user_id])
    if @invitation.save
#      if User.find_by_id(session[:user_id])
        Mailer.invitation(@invitation, signup_url(@invitation.token)).deliver
        flash[:notice] = "Ihre Einladung wurde gesendet."
        redirect_to root_path
#      else
#        Mailer.notification.deliver
#        flash[:notice] = "Sie werden benachrichtigt, wenn die beta-Phase beendet ist."
#        redirect_to authentication_login_path
#      end
    else
      flash[:notice] = "Ihre E-Mailadresse ist dem System bereits bekannt."
      redirect_to authentication_login_path
    end
  end

  def mail
    @invitation = Invitation.find(params[:id])
    if User.find_by_id(session[:user_id]).admin?
      Mailer.invitation(@invitation, signup_url(@invitation.token)).deliver
      flash[:notice] = "Einladung wurde gesendet."
    else
      flash[:error] = "Keine Berechtigung"
    end
    redirect_to invitations_path
  end

  def index
    @invitations = Invitation.page(params[:page]).per(15).order("created_at DESC")
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    redirect_to(invitations_url)
  end
end
