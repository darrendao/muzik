require 'lib/playlist_generator'
class PlaylistsController < ApplicationController
  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = Playlist.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @playlists }
    end
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
    @playlist = Playlist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @playlist }
    end
  end

  # GET /playlists/new
  # GET /playlists/new.json
  def new
    @playlist = Playlist.new(params[:playlist])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @playlist }
    end
  end

  # GET /playlists/1/edit
  def edit
    @playlist = Playlist.find(params[:id])
  end

  # POST /playlists
  # POST /playlists.json
  def create
    playlist = Playlist.new(params[:playlist])
    @group = Group.find(playlist.group_id)
    start_date = params[:start_date]
    end_date = params[:end_date]

    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)

    gen = PlaylistGenerator.new

    @playlists = []
    success = true
    (start_date..end_date).each do |date|
      pl = Playlist.find_or_create_by_date_and_group_id(date, @group.id)
      logger.info "GOING TO GENERATE"
      songslist = gen.generate(@group, @playlists[-1])

      unless songslist
        success = false
        break
      end
      pl.content = songslist.to_json
      pl.save
      @playlists << pl
    end
    if !success
      render :text => "Failed to generate playlist. Most likely there isn't enough songs and/or rules are too restrictive."
      return
    end
  end

  # PUT /playlists/1
  # PUT /playlists/1.json
  def update
    @playlist = Playlist.find(params[:id])

    respond_to do |format|
      if @playlist.update_attributes(params[:playlist])
        format.html { redirect_to @playlist, :notice => 'Playlist was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @playlist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy

    respond_to do |format|
      format.html { redirect_to playlists_url }
      format.json { head :ok }
    end
  end

  def fetch
    group_id = params[:group_id] || 1
    result = {}
    plists = Playlist.where(:group_id => group_id)
    plists.each do |pl|
      result[pl.date] = JSON.parse(pl.content)
    end
    respond_to do |format|
      format.html {
        render :text => result.inspect
      }
      format.json {
        render :json => result
      }
    end
  end
end
