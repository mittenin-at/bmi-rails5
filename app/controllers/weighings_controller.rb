# encoding: utf-8
class WeighingsController < ApplicationController
  def index
    @weighings = Weighing.page(params[:page]).per(15).order("date desc").where(user_id: session[:user_id])
  end

  def show
    @weighing = Weighing.find_by_id_and_user_id(params[:id], session[:user_id])
  end

  def new
    last_weighing = Weighing.find_all_by_user_id(session[:user_id]).last
    @last_weight = last_weighing.weight if last_weighing
    @last_abdomnal_girth = last_weighing.abdominal_girth if last_weighing
    @last_adipose = last_weighing.adipose if last_weighing
    @weighing = Weighing.new
  end

  def edit
    @weighing = Weighing.find_by_id_and_user_id(params[:id], session[:user_id])
  end

  def create
    @weighing = Weighing.new(params[:weighing])
    @weighing.user_id =  session[:user_id]
    if @weighing.save
      redirect_to(:action => "diagram", :notice => 'Wägung wurde erfolgreich erzeugt.')
    else
      render :action => "new"
    end
  end

  def update
    @weighing = Weighing.find_by_id_and_user_id(params[:id], session[:user_id])
    @weighing.user_id =  session[:user_id]

    if @weighing.update_attributes(params[:weighing])
      redirect_to(@weighing, :notice => 'Wägung wurde erfolgreich aktualisiert.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @weighing = Weighing.find_by_id_and_user_id(params[:id], session[:user_id])
    @weighing.destroy
    redirect_to(weighings_url)
  end

  def diagram
    @weighings = Weighing.order("date").find_all_by_user_id(session[:user_id])
    if @weighings.count == 0
      flash[:notice] = "Noch keine Wägung eingetragen!"
      redirect_to(:action => 'new')
    else
      @height = User.find(session[:user_id]).height
      unless current_user.target.nil?
        @target = (current_user.target * 100 * 100 / @height / @height).round(2) 
      end
     
    end
  end
  
  def select_competitor
    @competitors= User.find_all_by_public(true)
  end
  
  def compare
    @weighings = Weighing.order("date").find_all_by_user_id(session[:user_id])
    @compared = Weighing.order("date").find_all_by_user_id(params[:competitor][:id])
    if @weighings.count == 0
      flash[:notice] = "Noch keine Wägung eingetragen!"
      redirect_to(:action => 'new')
    else
      @height = User.find(session[:user_id]).height
      @height_competitor = User.find(params[:competitor][:id]).height 
      unless current_user.target.nil?
        @target = (current_user.target * 100 * 100 / @height / @height).round(2) 
      end
    end
  end
end