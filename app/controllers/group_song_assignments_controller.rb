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
end
