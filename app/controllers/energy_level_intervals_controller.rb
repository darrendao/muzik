class EnergyLevelIntervalsController < ApplicationController
  def destroy
    @eli = EnergyLevelInterval.find(params[:id])
    schedule_id = @eli.schedule_id
    @eli.destroy

    respond_to do |format|
      format.html { redirect_to :controller => 'energy_level_wizard', :schedule_id => schedule_id}
    end
  end
end
