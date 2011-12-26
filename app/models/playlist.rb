class Playlist < ActiveRecord::Base
  belongs_to :group
  validates :date, :uniqueness => {:scope => :group_id}
  def songs_list
    if content
      JSON.parse(content)
    else
      nil
    end
  end
  def songs_in_interval(start_time, end_time)
    songs = []
    if content
      songs_list.each do |song|
        songs << song if start_time <= song['timestamp'] && song['timestamp'] <= end_time
      end
    end
    songs
  end
  def songs_in_hour(hour)
    start_time = hour*60*60
    end_time = (hour + 1)*60*60
    songs_in_interval(start_time, end_time)
  end
end
