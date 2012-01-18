class SchedulesController < ApplicationController
  # GET /schedules
  # GET /schedules.json
  def index
    @schedules = Schedule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @schedules }
    end
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @schedule }
    end
  end

  # GET /schedules/new
  # GET /schedules/new.json
  def new
    @schedule = Schedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @schedule }
    end
  end

  # GET /schedules/1/edit
  def edit
    @schedule = Schedule.find(params[:id])
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(params[:schedule])
    @schedule.location_id = params[:location_id]

    respond_to do |format|
      if @schedule.save
        format.js{
          # This is for the ajax call from the location view
          @schedules = @schedule.location.schedules.special
          render 'list'
        }
        format.html { redirect_to @schedule, :notice => 'Schedule was successfully created.' }
        format.json { render :json => @schedule, :status => :created, :location => @schedule }
      else
        format.html { render :action => "new" }
        format.json { render :json => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /schedules/1
  # PUT /schedules/1.json
  def update
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        format.html { redirect_to @schedule, :notice => 'Schedule was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule = Schedule.find(params[:id])
    @location = @schedule.location
    @schedule.destroy

    respond_to do |format|
      format.js{
        # This is for the ajax call from the location view
        @schedules = @schedule.location.schedules.special
        render 'list'
      }
      format.html { redirect_to schedules_url }
      format.json { head :ok }
    end
  end
end
