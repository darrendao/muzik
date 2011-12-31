class Group < ActiveRecord::Base
  has_many :songs, :through => :group_song_assignments
  has_many :group_song_assignments, :dependent => :destroy
  has_many :playlists
  has_many :locations
  has_many :energy_level_intervals
  has_many :group_holiday_schedules
  accepts_nested_attributes_for :energy_level_intervals, :allow_destroy => true,
                                :reject_if => proc {|attrs|
                                  attrs.any? {|k,v| v.blank?}
                                }

  # Given the time (in second since midnight), returns the appropriate energy level for that time
  # Returns nil if unknown
  def energy_level_at(time)
    energy_level = nil

    energy_level_intervals.each do |eli|
      if eli.contain_time?(time)
        energy_level = eli.energy_level
      end
    end
    return energy_level
  end

  # Given the song id, return its energy level
  def energy_level_of(song_id)
    energy_level = nil
    group_song_assignments.each do |gsa|
      if gsa.song_id == song_id
        return gsa.energy_level
      end
    end
  end

  # Return array of songs together with their energy levels for this group
  def songs_library
    result = []
    gsas = GroupSongAssignment.where(:group_id => id).includes(:song, :energy_level)
    gsas.each do |gsa|
      song = gsa.song.entry_for_playlist
      song[:energy_level] = gsa.energy_level.name
      song[:energy_level_value] = gsa.energy_level.elevel
      result << song
    end
    result
  end
end
