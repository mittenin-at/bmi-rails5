# encoding: utf-8
class WeighingsController < ApplicationController
  def index
    @weighings = Weighing.page(params[:page]).per(15).order("date desc").where(user_id: session[:user_id])
  end

  def show
    @weighing = Weighing.find_by(id: params[:id], user_id: session[:user_id])
  end

  def new
    last_weighing = Weighing.find_by(user_id: session[:user_id])
    @last_weight = last_weighing.weight if last_weighing
    @last_abdomnal_girth = last_weighing.abdominal_girth if last_weighing
    @last_adipose = last_weighing.adipose if last_weighing
    @weighing = Weighing.new
  end

  def edit
    @weighing = Weighing.find_by(id: params[:id], user_id: session[:user_id])
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
    @weighing = Weighing.find_by(id: params[:id], user_id: session[:user_id])
    @weighing.user_id =  session[:user_id]

    if @weighing.update_attributes(params[:weighing])
      redirect_to(@weighing, :notice => 'Wägung wurde erfolgreich aktualisiert.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @weighing = Weighing.find_by(id: params[:id], user_id: session[:user_id])
    @weighing.destroy
    redirect_to(weighings_url)
  end

  def diagram
    @startdate = Weighing.where(user_id: session[:user_id]).minimum(:date).to_time
    @weighings = Weighing.order("date").where(user_id: session[:user_id])
    if @weighings.count == 0
      flash[:notice] = "Noch keine Wägung eingetragen!"
      redirect_to(:action => 'new')
    else
      @height = current_user.height
      unless current_user.target.nil?
        @target = (current_user.target * 100 * 100 / @height / @height).round(2)
        @minbmi = [@weighings.min_by { |w| w.weight }.weight * 10000 / @height / @height, @target].min - 0.5
        @maxbmi = [@weighings.max_by { |w| w.weight }.weight * 10000 / @height / @height, @target].max + 0.5
      else
        @minbmi = @weighings.min_by { |w| w.weight }.weight * 10000 / @height / @height - 0.5
        @maxbmi = @weighings.max_by { |w| w.weight }.weight * 10000 / @height / @height + 0.5
      end
    end
  end

  def select_competitor
    @competitors = User.where(public: true)
  end

  def compare
    case params[:timespan]
    when "full"
      @startdate = [ Weighing.where(user_id: session[:user_id]).minimum(:date),
                     Weighing.where(user_id: params[:competitor][:id]).minimum(:date) ].min.to_time
    when "year"
      @startdate = Time.now - 1.year
    when "quarter"
      @startdate = Time.now - 3.month
    when "month"
      @startdate = Time.now - 1.month
    end
      @weighings = Weighing.order("date").where(user_id:session[:user_id], date: @startdate..Time.now)
      @compared = Weighing.order("date").where(user_id:params[:competitor][:id], date: @startdate..Time.now)
    unless @weighings
      flash[:notice] = "Noch keine Wägung eingetragen!"
      redirect_to(:action => 'new')
    else
      @height = User.find(session[:user_id]).height
      @height_competitor = User.find(params[:competitor][:id]).height
      @minbmi = [ @weighings.min_by { |w| w.weight }.weight * 10000 / @height / @height,
                  @compared.min_by { |w| w.weight }.weight * 10000 / @height_competitor /
                  @height_competitor ].min - 0.5

      @maxbmi = [@weighings.max_by { |w| w.weight }.weight * 10000 / @height / @height ,
                 @compared.max_by { |w| w.weight }.weight * 10000 / @height_competitor /
                 @height_competitor ].max + 0.5
    end
  end
end