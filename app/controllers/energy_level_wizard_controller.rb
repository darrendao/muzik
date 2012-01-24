class EnergyLevelWizardController < ApplicationController
  def index
    @schedule = Schedule.find(params[:schedule_id])
    @energy_level_intervals = @schedule.energy_level_intervals
  end

  def add_energy_level_interval
    if params[:dates].nil? or params[:dates].empty?
      flash[:alert] = 'You need to select at least one day'
      redirect_to :action => 'index',
                  :schedule_id => params[:energy_level_interval][:schedule_id]
      return
    end

    success = true
    dates = params[:dates]
    dates.each do |date|
      # Create new energy level interval
      eli = EnergyLevelInterval.new(params[:energy_level_interval])
      eli.wday = date
      success = eli.save
      break if !success
    end

    respond_to do |format|
      if success
        format.html {
          flash[:notice] = 'Energy level interval was successfully created.'
          redirect_to :action => 'index',
                      :schedule_id => params[:energy_level_interval][:schedule_id]
        }
        format.json { render :json => @energy_level, :status => :created, :location => @energy_level }
      else
        format.html { render :action => "index" }
      end
    end
  end

  def update_energy_level_intervals
    eli = nil
    inputs = {}
    params.each do |key, value|
      if key =~ /eli_slider_(\d+)_start_at/
        inputs[$1] ||= {}
        inputs[$1][:start_at] = value
      elsif key =~ /eli_slider_(\d+)_end_at/
        inputs[$1] ||= {}
        inputs[$1][:end_at] = value
      end
    end
    inputs.each do |id, time|
      eli = EnergyLevelInterval.find(id)
      eli.start_at = time[:start_at]
      eli.end_at = time[:end_at]
      eli.save
    end
    redirect_to :action => 'index', :schedule_id => eli.schedule_id
  end
end
