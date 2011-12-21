class GroupSongAssignment < ActiveRecord::Base
#  validates_uniqueness_of :song_id, :scope => :group_id
  belongs_to :song
  belongs_to :group
  belongs_to :energy_level
end
