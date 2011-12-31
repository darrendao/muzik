class Location < ActiveRecord::Base
  has_many :business_hours, :as => :schedulable
  accepts_nested_attributes_for :business_hours, :allow_destroy => true,
                                :reject_if => proc {|attrs|
                                  attrs.any? {|k,v| v.blank?}
                                }

  belongs_to :group
  has_many :black_lists
  has_one :media_player
  accepts_nested_attributes_for :media_player, :allow_destroy => true,
                                :reject_if => proc {|attrs|
                                  [:hostname, :serial].all? {|k| attrs[k].blank?}
                                }

  def blacklisted_songs
    ret = []
    ::BlackList.where(:location_id => id).includes(:song).each do | blacklist |
      ret << blacklist.song.entry_for_playlist
    end
    ret
  end
end
