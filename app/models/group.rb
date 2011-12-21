class Group < ActiveRecord::Base
  has_many :songs, :through => :group_song_assignments
  has_many :group_song_assignments, :dependent => :destroy
  has_many :locations
  has_many :energy_level_intervals
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

  def songs_with_energy_level
    ret = {}
    ret['song']
  end
end
