class MediaPlayersController < ApplicationController
  # GET /media_players
  # GET /media_players.json
  def index
    @media_players = MediaPlayer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @media_players }
    end
  end

  # GET /media_players/1
  # GET /media_players/1.json
  def show
    @media_player = MediaPlayer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @media_player }
    end
  end

  # GET /media_players/new
  # GET /media_players/new.json
  def new
    @media_player = MediaPlayer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @media_player }
    end
  end

  # GET /media_players/1/edit
  def edit
    @media_player = MediaPlayer.find(params[:id])
  end

  # POST /media_players
  # POST /media_players.json
  def create
    @media_player = MediaPlayer.new(params[:media_player])

    respond_to do |format|
      if @media_player.save
        format.html { redirect_to @media_player, :notice => 'Media player was successfully created.' }
        format.json { render :json => @media_player, :status => :created, :location => @media_player }
      else
        format.html { render :action => "new" }
        format.json { render :json => @media_player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /media_players/1
  # PUT /media_players/1.json
  def update
    @media_player = MediaPlayer.find(params[:id])

    respond_to do |format|
      if @media_player.update_attributes(params[:media_player])
        format.html { redirect_to @media_player, :notice => 'Media player was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @media_player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /media_players/1
  # DELETE /media_players/1.json
  def destroy
    @media_player = MediaPlayer.find(params[:id])
    @media_player.destroy

    respond_to do |format|
      format.html { redirect_to media_players_url }
      format.json { head :ok }
    end
  end

  def datatable
    respond_to do |format|
      format.json do
        render(:json => MediaPlayer.for_data_table(self, %w(id nil location_id hostname ip_address serial), %w(location_id hostname ip_address serial)) do |media_player|
          action_links = "<a href='/media_players/#{media_player.id}'>View</a>" + " " +
                         "<a href='/media_players/#{media_player.id}/edit'>Edit</a>"
          [media_player.id, action_links, media_player.location_id, media_player.hostname, media_player.ip_address, media_player.serial]
        end)
      end
    end
  end

  def delete
    media_player_ids = params[:media_player_ids]
    media_player_ids.split(",").each do |id|
      media_player = MediaPlayer.find(id)
      media_player.destroy
    end
    respond_to do |format|
      format.js do
        render 'update_media_player_table'
      end
    end
  end

  def location_info
    result = {}
    hostname = params[:hostname]
    player = nil
    location = nil

    if hostname
      player = MediaPlayer.where(:hostname => hostname).first
    end

    if player
      location = player.location
      if location
        business_hours = location.business_hours
        result[:business_hours] = business_hours
      end
      if location.group
        result[:group] = location.group
        energy_level_intervals = location.group.energy_level_intervals
        result[:energy_level_intervals] = energy_level_intervals
      end
    end


    respond_to do |format|
      format.json do
        render :json => result.to_json
      end
      format.html do
        render :text => result.inspect
      end
    end
  end
end
