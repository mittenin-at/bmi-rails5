class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_only, :except => [:show, :edit, :update, :new, :create]
  skip_before_action :authorize, :only => [:new, :create]

  def index
    @users = User.page(params[:page]).per(15).order("email")
  end

  def show
  end

  def new
    @user = User.new(:invitation_token => params[:invitation_token])
    @user.email = @user.invitation.recipient_email if @user.invitation
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if User.all.count == 0
      @user.admin = true
    end
    if @user.save
      session[:user_id] = @user.id
      redirect_to(weighings_url, :notice => 'Ihr Account wurde erfolgreich angelegt.')
    else
      render :action => "new"
    end
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to(weighings_url, :notice => 'Ihr Account wurde erfolgreich aktualisiert.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to(users_url)
  end

private
  def set_user
    @user = if User.find(session[:user_id]).admin?
              User.find(params[:id])
            else
              User.find(session[:user_id])
            end
  end

  def user_params
    params.require(:user)
          .permit(:users, :email, :password, :password_confirmation, :height, 
                  :target, :public, :admin, :invitation_token)
  end
end