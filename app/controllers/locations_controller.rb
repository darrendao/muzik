class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    @location = Location.new
    (0..6).each do |i|
      bus_hour = @location.business_hours.build
      bus_hour.wday = i
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
    existing_business_days = []
    @location.business_hours.each do |i|
      existing_business_days << i.wday
    end
    (0..6).each do |i|
      next if existing_business_days.include? i
      loc = @location.business_hours.build
      loc.wday = i
    end
    @location.business_hours.sort!{|x,y| x.wday <=> y.wday}

  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(params[:location])

    if @location.media_player
      unless !@location.media_player.serial.empty? or @location.media_player.hostname or !@location.media_player.ip_address.empty?
        @location.media_player.destroy
      end
    end

    default_schedule = Schedule.new(:name => 'Default Schedule')
    @location.schedules << default_schedule

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, :notice => 'Location was successfully created.' }
        format.json { render :json => @location, :status => :created, :location => @location }
      else
        format.html { render :action => "new" }
        format.json { render :json => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, :notice => 'Location was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :ok }
    end
  end

  def datatable
    respond_to do |format|
      format.json do
        render(:json => Location.for_data_table(self, %w(id nil name address phone_number contact_name), %w(name address phone_number contact_name)) do |location|
          action_links = "<a href='/locations/#{location.id}'>View</a>" + " " +
                         "<a href='/locations/#{location.id}/edit'>Edit</a>"
          [location.id, action_links, location.name, location.address, location.phone_number, location.contact_name]
        end)
      end
    end
  end

  def delete
    location_ids = params[:location_ids]
    location_ids.split(",").each do |id|
      location = Location.find(id)
      location.destroy
    end
    respond_to do |format|
      format.js do
        render :nothing
      end
    end
  end

  def blacklist_songs
    song_ids = params[:song_ids]
    location_id = params[:location_id]
    song_ids.split(",").each do |id|
      bl = BlackList.new
      bl.location_id = location_id
      bl.song_id = id
      bl.save
    end
    @location = Location.find(location_id)
    render "/locations/update_blacklisttable"
  end

  # Handle ajax call for displaying energy level intervals for selected schedule
  def refresh_energy_level_intervals
    @schedule = Schedule.find(params[:selected_schedule])
  end

  # Used by client
  # Return energy level intervals of the specified location for the given date range
  def energy_level_intervals
    result = {}
    @location = Location.find(params[:location_id])
    start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
    end_date = params[:end_date] ? Date.parse(params[:end_date]) : Date.today

    (start_date..end_date).each do |date|
      result[date] = @location.energy_level_intervals(date)
    end

    render :json => result
  end

  # Used by client
  # Return schedules of the specified location for the given date range
  def schedules
    result = {}
    @location = Location.find(params[:location_id])
    start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
    end_date = params[:end_date] ? Date.parse(params[:end_date]) : Date.today
    (start_date..end_date).each do |date|
      result[date] = @location.schedule_at(date)
    end
    render :json => result
  end
end
