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
    (1..7).each do |i|
      @location.business_hours.build
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
    (@location.business_hours.size..7).each do |i|
      @location.business_hours.build
    end
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
end
