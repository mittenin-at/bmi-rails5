class UsersController < ApplicationController
  before_filter :admin_only, :except => [:show, :edit, :update, :new, :create]
  skip_filter :authorize, :only => [:new, :create]

  def index
    @users = User.page(params[:page]).per(15).order("email")
  end

  def show
    if admin?
      @user = User.find(params[:id])
    else
      @user = User.find(session[:user_id])
    end
  end

  def new
    @user = User.new(:invitation_token => params[:invitation_token])
    @user.email = @user.invitation.recipient_email if @user.invitation
  end

  def edit
    if admin?
      @user = User.find(params[:id])
    else
      @user = User.find(session[:user_id])
    end
  end

  def create
    @user = User.new(params[:user])
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
    if admin?
      @user = User.find(params[:id])
    else
      @user = User.find(session[:user_id])
    end

    if @user.update_attributes(params[:user])
      redirect_to(weighings_url, :notice => 'Ihr Account wurde erfolgreich aktualisiert.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to(users_url)
  end

  protected

  def admin?
    User.find(session[:user_id]).admin?
  end
end