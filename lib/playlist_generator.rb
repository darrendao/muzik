class PlaylistGenerator
  def initialize(group, rules)
    @group = group
    @rules = rules
  end
  def generate
    songs = @group.songs
    current_time = 0
    current_hour_songs = [] # list of songs that had been play for this hour

    while candidate = songs.pop
      # Don't play songs of the same artist or album that have been played during the last hour
      next if current_hour_songs.any?{|song| song.artist == candidate.artist or song.album == candidate.album}
    end
  end
end