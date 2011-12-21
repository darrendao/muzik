class EnergyLevelInterval < ActiveRecord::Base
  belongs_to :energy_level
  belongs_to :group

  # Given the time (in sec) from midnight, determine if it falls within
  # the interval of this energy level interval
  def contain_time?(time_sec)
    start_sec = start_at.hour * 60 * 60 + start_at.min * 60
    end_sec = end_at.hour * 60 * 60 + end_at.min * 60
    if start_sec <= time_sec && time_sec < end_sec
      return true
    else
      return false
    end
  end
end
