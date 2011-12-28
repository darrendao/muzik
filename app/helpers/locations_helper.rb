module LocationsHelper
  def setup_location(location)
    location.build_media_player unless location.media_player
    location
  end
end
