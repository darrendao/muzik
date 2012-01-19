class Location < ActiveRecord::Base
  has_one :holiday_song_period, :dependent => :destroy
  accepts_nested_attributes_for :holiday_song_period, :allow_destroy => true

  has_many :schedules, :dependent => :destroy
  accepts_nested_attributes_for :schedules, :allow_destroy => true

  has_many :business_hours, :as => :schedulable
  accepts_nested_attributes_for :business_hours, :allow_destroy => true,
                                :reject_if => proc {|attrs|
                                  attrs.any? {|k,v| v.blank?}
                                }

  belongs_to :group
  has_many :black_lists
  has_one :media_player
  accepts_nested_attributes_for :media_player, :allow_destroy => true
#                                :reject_if => proc {|attrs|
#                                  [:hostname, :serial].all? {|k| attrs[k].blank?}
#                                }


  def blacklisted_songs
    ret = []
    ::BlackList.where(:location_id => id).includes(:song).each do | blacklist |
      ret << blacklist.song.entry_for_playlist(true)
    end
    ret
  end

  # Return the schedule for the current day
  def current_schedule
    today = Time.zone.now
    return schedule_at(today)
  end

  def default_schedule
    schedules.where(:name => "Default Schedule").first
  end

  # Given a date, figure out what schedule this location has
  def schedule_at(date)
    schedules.special.each do |schedule|
      if schedule.start_at <= date && date <= schedule.end_at
        return schedule
      end
    end
    return default_schedule
  end

  # return energy level intervals for the given date
  def energy_level_intervals(date)
    result = []
    schedule = schedule_at(date)
    elis = schedule.energy_level_intervals
    if elis.nil? or elis.empty?
      elis = default_schedule.energy_level_intervals
    end

    elis.each do |eli|
      if eli.wday == date.wday
        result << eli
      end
    end
    return result
  end
end
