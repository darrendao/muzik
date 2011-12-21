class Group < ActiveRecord::Base
  has_many :songs, :through => :group_song_assignments
  has_many :group_song_assignments, :dependent => :destroy
  has_many :locations
  has_many :energy_level_intervals
  accepts_nested_attributes_for :energy_level_intervals, :allow_destroy => true,
                                :reject_if => proc {|attrs|
                                  attrs.any? {|k,v| v.blank?}
                                }
end
