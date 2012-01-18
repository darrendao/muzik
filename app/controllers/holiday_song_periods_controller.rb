class HolidaySongPeriodsController < ApplicationController
  # GET /holiday_song_periods
  # GET /holiday_song_periods.json
  def index
    @holiday_song_periods = HolidaySongPeriod.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @holiday_song_periods }
    end
  end

  # GET /holiday_song_periods/1
  # GET /holiday_song_periods/1.json
  def show
    @holiday_song_period = HolidaySongPeriod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @holiday_song_period }
    end
  end

  # GET /holiday_song_periods/new
  # GET /holiday_song_periods/new.json
  def new
    @holiday_song_period = HolidaySongPeriod.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @holiday_song_period }
    end
  end

  # GET /holiday_song_periods/1/edit
  def edit
    @holiday_song_period = HolidaySongPeriod.find(params[:id])
  end

  # POST /holiday_song_periods
  # POST /holiday_song_periods.json
  def create
    @holiday_song_period = HolidaySongPeriod.new(params[:holiday_song_period])

    respond_to do |format|
      if @holiday_song_period.save
        format.html { redirect_to @holiday_song_period, :notice => 'Holiday song period was successfully created.' }
        format.json { render :json => @holiday_song_period, :status => :created, :location => @holiday_song_period }
      else
        format.html { render :action => "new" }
        format.json { render :json => @holiday_song_period.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /holiday_song_periods/1
  # PUT /holiday_song_periods/1.json
  def update
    @holiday_song_period = HolidaySongPeriod.find(params[:id])

    respond_to do |format|
      if @holiday_song_period.update_attributes(params[:holiday_song_period])
        format.html { redirect_to @holiday_song_period, :notice => 'Holiday song period was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @holiday_song_period.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /holiday_song_periods/1
  # DELETE /holiday_song_periods/1.json
  def destroy
    @holiday_song_period = HolidaySongPeriod.find(params[:id])
    @holiday_song_period.destroy

    respond_to do |format|
      format.html { redirect_to holiday_song_periods_url }
      format.json { head :ok }
    end
  end
end
