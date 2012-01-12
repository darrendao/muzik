class GroupSongAssignmentsController < ApplicationController
  # GET /group_song_assignments
  # GET /group_song_assignments.json
  def index
    @group_song_assignments = GroupSongAssignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @group_song_assignments }
    end
  end

  # GET /group_song_assignments/1
  # GET /group_song_assignments/1.json
  def show
    @group_song_assignment = GroupSongAssignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @group_song_assignment }
    end
  end

  # GET /group_song_assignments/new
  # GET /group_song_assignments/new.json
  def new
    @group_song_assignment = GroupSongAssignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @group_song_assignment }
    end
  end

  # GET /group_song_assignments/1/edit
  def edit
    @group_song_assignment = GroupSongAssignment.find(params[:id])
  end

  # POST /group_song_assignments
  # POST /group_song_assignments.json
  def create
    @group_song_assignment = GroupSongAssignment.new(params[:group_song_assignment])

    respond_to do |format|
      if @group_song_assignment.save
        format.html {
          if request.env["HTTP_REFERER"].include? "groups"
            redirect_to @group_song_assignment.group
          else
            redirect_to @group_song_assignment, :notice => 'Group song assignment was successfully created.'
          end
        }
        format.js {
          if request.env["HTTP_REFERER"].include? "groups"
            @group = @group_song_assignment.group
            render "/groups/update_songtable"
          end
        }
        format.json {
          render:json => @group_song_assignment, :status => :created, :location => @group_song_assignment
        }
      else
        format.html { render :action => "new" }
        format.json { render :json => @group_song_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /group_song_assignments/1
  # PUT /group_song_assignments/1.json
  def update
    @group_song_assignment = GroupSongAssignment.find(params[:id])

    respond_to do |format|
      if @group_song_assignment.update_attributes(params[:group_song_assignment])
        format.html { redirect_to @group_song_assignment, :notice => 'Group song assignment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @group_song_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /group_song_assignments/1
  # DELETE /group_song_assignments/1.json
  def destroy
    @group_song_assignment = GroupSongAssignment.find(params[:id])
    @group_song_assignment.destroy

    respond_to do |format|
      format.html { redirect_to group_song_assignments_url }
      format.json { head :ok }
    end
  end

  def upload_itunes_plist
    return if !params[:group_song_assignment]
    
    songs = parse_itunes_plist(params[:group_song_assignment][:uploaded_itunes_plist])

    tmp = parse_itunes_plist_filename(params[:group_song_assignment][:uploaded_itunes_plist].original_filename)
    group_name = tmp[:client]

    energy_level = EnergyLevel.where(:name => tmp[:energy_level]).first
    group = Group.where(:name => group_name).first
    assign_songs_to_group(songs, group, energy_level)
  end

  private
  def parse_itunes_plist_filename(filename)
    result = {}
    tokens = filename.split('.')
    if tokens.size != 6
      result[:error] = "Invalid filename standard. Unable to figure out client name and energy level"
      return result
    end

    result[:client] = tokens[1]
    result[:energy_level] = tokens[4]
    result
  end

  def parse_itunes_plist(itunes_plist)
    Tpg::ItunesPlistParser::parse(itunes_plist)
  end

  # TODO: need to worry about ACID properties
  def assign_songs_to_group(songs_list, group, energy_level)
    gsas = []
    songs_list.each do |song_hash|
      song = Song.where(:itunes_persistent_id => song_hash['Persistent ID']).first
      # Create song if it's not there
      if song.nil?
        song = create_song(song_hash)
      end

      gsas << GroupSongAssignment.new(:song_id => song.id, :group_id => group.id, :energy_level_id => energy_level.id)
    end

    # Create group_song_assignments. This will also blow out the old assignments
    # TODO: figure out how to mass delete and mass insert to speed things up
    group.group_song_assignments = gsas
  end

  def create_song(song_hash)
    artist = song_hash['Artist']
    album = song_hash['Album']
    title = song_hash['Name']
    filename = "#{Tpg::Utils::md5_from_meta([artist, album, title])}.mp3"
    Song.create(:title => title,
                :belongs_to_album => album,
                :artist => artist,
                :itunes_persistent_id => song_hash['Persistent ID'],
                :duration => song_hash['Total Time'].to_i / 1000,
                :file_path => filename)
  end
end
