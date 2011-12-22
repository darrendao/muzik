class SongsController < ApplicationController
  autocomplete :song, :title
  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @songs }
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    @song = Song.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @song }
    end
  end

  # GET /songs/new
  # GET /songs/new.json
  def new
    @song = Song.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @song }
    end
  end

  # GET /songs/1/edit
  def edit
    @song = Song.find(params[:id])
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(params[:song])

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, :notice => 'Song was successfully created.' }
        format.json { render :json => @song, :status => :created, :location => @song }
      else
        format.html { render :action => "new" }
        format.json { render :json => @song.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /songs/1
  # PUT /songs/1.json
  def update
    @song = Song.find(params[:id])

    respond_to do |format|
      if @song.update_attributes(params[:song])
        puts "now.... #{@song.energy_level}"
        format.html { redirect_to @song, :notice => 'Song was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @song.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song = Song.find(params[:id])
    #@song.remove_file_path!
    @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :ok }
    end
  end

  def upload
    @song = Song.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @song }
    end
  end

  def datatable
    respond_to do |format|
      format.json do
        render(:json => Song.for_data_table(self, %w(action title artist belongs_to_album duration), %w(title artist belongs_to_album duration)) do |song|
          action_links = "<a href='/songs/#{song.id}'>View</a>" + " " +
                         "<a href='/songs/#{song.id}/edit'>Edit</a>" + " " +
                         "<a href='/songs/#{song.id}' data-confirm='Are you sure?' data-method='delete'>Delete</a>"
          [action_links, song.title, song.artist, song.belongs_to_album, song.duration]
        end)
      end
    end
  end
end
