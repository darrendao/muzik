class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new
    (1..7).each do |i|
      @group.energy_level_intervals.build
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
    (@group.energy_level_intervals.size..7).each do |i|
      @group.energy_level_intervals.build
    end
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, :notice => 'Group was successfully created.' }
        format.json { render :json => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.json { render :json => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, :notice => 'Group was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :ok }
    end
  end

  def datatable
    respond_to do |format|
      format.json do
        render(:json => Group.for_data_table(self, %w(id nil name), %w(name)) do |group|
          action_links = "<a href='/groups/#{group.id}'>View</a>"
          [group.id, action_links, group.name, group.locations.size]
        end)
      end
    end
  end

  def remove_location
    @group = Group.find(params[:group_id])
    location = Location.where(:id => params[:location_id], :group_id => params[:group_id])
    unless location.empty?
      location.first.group_id=nil
      location.first.save!
    end
    respond_to do |format|
      format.html
      format.js { render 'add_location'}
    end
  end

  def add_location
    location = Location.find(params[:location])
    location.group_id=params[:group_id]
    ret = location.save!
    @group = location.group
    respond_to do |format|
      format.html
      format.js
    end
  end

  def delete
    group_ids = params[:group_ids]
    group_ids.split(",").each do |group_id|
      group = Group.find(group_id)
      group.destroy
    end
    @groups = Group.all
    render :nothing => true
  end

  def gen_playlist
    group_id = params[:group_id]
    num_day = params[:num_day]
  end
end
