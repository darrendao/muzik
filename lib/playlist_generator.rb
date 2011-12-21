class PlaylistGenerator
  def initialize(options={})
    @options = options
  end
  def generate(group, start_time = 0, end_time = 86400)
    playlist = {}
    songs = group.songs
    songs_counter = songs.size
    current_time = start_time              # seconds since midnight
    current_hour = start_time / (60*60)    # hours since midnight
    current_hour_songs = [] # list of songs that had been play for this hour
    current_time_energy_level = group.energy_level_at(current_time)

    while candidate = songs.shift
      puts "Current energy level is #{current_time_energy_level.inspect}"
      songs_counter = songs_counter - 1
      if songs_counter < 0
        raise "CRAP... NO MORE SONG. CAN'T CREATE PLAYLIST"
      end

      # Don't play songs of the same artist or album that have been played during the last hour
      if current_hour_songs.any?{|song| song.artist == candidate.artist or song.album == candidate.album}
        puts "Skipping #{candidate.title} because of artist or album conflict"
        songs.push(candidate)
        next
      end

      # Don't play songs that don't match the energy level
      # If no energy level specified for current time, then we don't care
      song_energy_level = group.energy_level_of(candidate.id)
      if current_time_energy_level && current_time_energy_level != song_energy_level
        puts "Skipping #{candidate.title} because of energy level conflict. Song energy level is #{song_energy_level.inspect}"
        songs.push(candidate)
        next
      end

      # TODO: check that song wasn't used in the same hour yesterday

      # All conditions meet. Add song to playlist
      puts "Adding #{candidate.title} to playlist"
      playlist[current_time] = candidate
      current_time += candidate.duration

      # See if at the end of this song, we're in a new hour. If so, then re-initialize things
      new_hour = current_time / (60*60)
      if new_hour > current_hour
        current_hour_songs = []
        current_time_energy_level = group.energy_level_at(current_time)
      end
      current_hour_songs << candidate

      # See if we're done
      if current_time >= end_time
        break
      end
    end
    return playlist
  end
end