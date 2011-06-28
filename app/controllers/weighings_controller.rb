# encoding: utf-8
class WeighingsController < ApplicationController
  # GET /weighings
  # GET /weighings.xml
  def index
    @weighings = Weighing.order("date desc").find_all_by_user_id(session[:user_id])
  end

  # GET /weighings/1
  # GET /weighings/1.xml
  def show
    @weighing = Weighing.find_by_id_and_user_id(params[:id], session[:user_id])
  end

  # GET /weighings/new
  # GET /weighings/new.xml
  def new
    @weighing = Weighing.new
  end

  # GET /weighings/1/edit
  def edit
    @weighing = Weighing.find_by_id_and_user_id(params[:id], session[:user_id])
  end

  # POST /weighings
  # POST /weighings.xml
  def create
    @weighing = Weighing.new(params[:weighing])
    @weighing.user_id =  session[:user_id]
    if @weighing.save
      redirect_to(@weighing, :notice => 'Weighing was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /weighings/1
  # PUT /weighings/1.xml
  def update
    @weighing = Weighing.find_by_id_and_user_id(params[:id], session[:user_id])
    @weighing.user_id =  session[:user_id]

    if @weighing.update_attributes(params[:weighing])
      redirect_to(@weighing, :notice => 'Weighing was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /weighings/1
  # DELETE /weighings/1.xml
  def destroy
    @weighing = Weighing.find_by_id_and_user_id(params[:id], session[:user_id])
    @weighing.destroy
  end

  def diagram
    @weighings = Weighing.order("date").find_all_by_user_id(session[:user_id])
    if @weighings.count == 0
      flash[:notice] = "Noch keine Wägung eingetragen!"
      redirect_to(:action => 'new')
    else
      @height = User.find(session[:user_id]).height
      @minbmi = ( Weighing.minimum(:weight, :conditions => ['user_id = ?', session[:user_id]]) * 100 * 100 / @height / @height ).to_i - 1
      @maxbmi = ( Weighing.maximum(:weight, :conditions => ['user_id = ?', session[:user_id]]) * 100 * 100 / @height / @height ).to_i + 2
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
#      @minbmi = 15
#      @maxbmi = 45
      @minbmi = [( Weighing.minimum(:weight, :conditions => ['user_id = ?', session[:user_id]]) * 100 * 100 / @height / @height ),
                 ( Weighing.minimum(:weight, :conditions => ['user_id = ?', params[:competitor][:id]]) * 100 * 100 / @height_competitor / @height_competitor )].min.to_i
      
      @maxbmi = [( Weighing.maximum(:weight, :conditions => ['user_id = ?', session[:user_id]]) * 100 * 100 / @height / @height ),
                 ( Weighing.minimum(:weight, :conditions => ['user_id = ?', params[:competitor][:id]]) * 100 * 100 / @height_competitor / @height_competitor )].max.to_i + 1
    end
  end

end

