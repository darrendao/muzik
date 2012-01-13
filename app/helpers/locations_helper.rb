module LocationsHelper
  def setup_location(location)
    location.build_holiday_song_period unless location.holiday_song_period
    location.build_media_player unless location.media_player
    location
  end
end
