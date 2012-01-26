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
    #today = Time.zone.now
    today = Date.today
    return schedule_at(today)
  end

  def default_schedule
    schedules.where(:name => "Default Schedule").first
  end

  # Given a date, figure out what schedule this location has
  def schedule_at(date)
    schedules.special.each do |schedule|
      puts "Comparing #{schedule.inspect} and #{date.inspect}"
      if schedule.start_at.to_date <= date && date <= schedule.end_at.to_date
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

  def store_hours_epoch(start_date, end_date)
    result = []
    (start_date..end_date).each do |date|
      elis = energy_level_intervals(date)
      elis.each do |eli|
        store_hour = {
                       :close_at => convert_to_epoch(date, eli.end_at),
                       :open_at => convert_to_epoch(date, eli.start_at)
                     }
        result << store_hour
      end
    end
    result.sort_by{|time| time[:open_at]}
  end

  private
  # This assume the Rails app is using UTC
  def convert_to_epoch(date, time)
    Time.parse(date.to_s).to_i + time.hour * 60 * 60 + time.min * 60 + time.sec
  end
end
