class InvitationsController < ApplicationController
  before_action :admin_only, :except => [:new, :create]
  skip_before_action :authorize, :only => [:new, :create]

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.sender = User.find_by_id(session[:user_id])
    if @invitation.save
      Mailer.invitation(@invitation, signup_url(@invitation.token)).deliver
      flash[:notice] = "Ihre Einladung wurde gesendet."
      redirect_to root_path
    else
      flash[:notice] = "Ihre E-Mailadresse ist dem System bereits bekannt."
      redirect_to authentication_login_path
    end
  end

  def mail
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

private
  def invitation_params
    params.require(:invitation).permit(:recipient_email, :sender_id, :token)
  end
end
