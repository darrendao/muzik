class EnergyLevelsController < ApplicationController
  # GET /energy_levels
  # GET /energy_levels.json
  def index
    @energy_levels = EnergyLevel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @energy_levels }
    end
  end

  # GET /energy_levels/1
  # GET /energy_levels/1.json
  def show
    @energy_level = EnergyLevel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @energy_level }
    end
  end

  # GET /energy_levels/new
  # GET /energy_levels/new.json
  def new
    @energy_level = EnergyLevel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @energy_level }
    end
  end

  # GET /energy_levels/1/edit
  def edit
    @energy_level = EnergyLevel.find(params[:id])
  end

  # POST /energy_levels
  # POST /energy_levels.json
  def create
    @energy_level = EnergyLevel.new(params[:energy_level])

    respond_to do |format|
      if @energy_level.save
        format.html { redirect_to @energy_level, :notice => 'Energy level was successfully created.' }
        format.json { render :json => @energy_level, :status => :created, :location => @energy_level }
      else
        format.html { render :action => "new" }
        format.json { render :json => @energy_level.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /energy_levels/1
  # PUT /energy_levels/1.json
  def update
    @energy_level = EnergyLevel.find(params[:id])

    respond_to do |format|
      if @energy_level.update_attributes(params[:energy_level])
        format.html { redirect_to @energy_level, :notice => 'Energy level was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @energy_level.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /energy_levels/1
  # DELETE /energy_levels/1.json
  def destroy
    @energy_level = EnergyLevel.find(params[:id])
    @energy_level.destroy

    respond_to do |format|
      format.html { redirect_to energy_levels_url }
      format.json { head :ok }
    end
  end
end
