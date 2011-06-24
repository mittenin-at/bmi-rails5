class WeighingsController < ApplicationController
  # GET /weighings
  # GET /weighings.xml
  def index
    @weighings = Weighing.order("date desc").find_all_by_user_id(session[:user_id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @weighings }
    end
  end

  # GET /weighings/1
  # GET /weighings/1.xml
  def show
    @weighing = Weighing.find_by_id_and_user_id(params[:id], session[:user_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @weighing }
    end
  end

  # GET /weighings/new
  # GET /weighings/new.xml
  def new
    @weighing = Weighing.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @weighing }
    end
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
    respond_to do |format|
      if @weighing.save
        format.html { redirect_to(@weighing, :notice => 'Weighing was successfully created.') }
        format.xml  { render :xml => @weighing, :status => :created, :location => @weighing }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @weighing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /weighings/1
  # PUT /weighings/1.xml
  def update
    @weighing = Weighing.find_by_id_and_user_id(params[:id], session[:user_id])
    @weighing.user_id =  session[:user_id]

    respond_to do |format|
      if @weighing.update_attributes(params[:weighing])
        format.html { redirect_to(@weighing, :notice => 'Weighing was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @weighing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /weighings/1
  # DELETE /weighings/1.xml
  def destroy
    @weighing = Weighing.find_by_id_and_user_id(params[:id], session[:user_id])
    @weighing.destroy

    respond_to do |format|
      format.html { redirect_to(weighings_url) }
      format.xml  { head :ok }
    end
  end

  def diagram
    @weighings = Weighing.order("date").find_all_by_user_id(session[:user_id])
  end
end

