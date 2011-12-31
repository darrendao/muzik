require 'mp3info'
class Song < ActiveRecord::Base
  #attr_accessible :file_path, :checksum, :title, :artist, :length, :energy_level, :created_at, :updated_at
  #mount_uploader :file_path, SongUploader
  has_attached_file :mp3
  before_post_process :process_mp3
  acts_as_taggable

  def process_mp3
    self.file_path = mp3.path
    tmp_path = mp3.queued_for_write[:original].path
    Mp3Info.open(tmp_path) do |mp3_info|
      self.title = mp3_info.tag.title
      self.artist = mp3_info.tag.artist
      self.duration = mp3_info.length
      self.belongs_to_album = mp3_info.tag.album
    end
    self.checksum = Digest::MD5.file(tmp_path).hexdigest
  end

  def formatted_duration
    format('%02d:%02d', *duration.divmod(60))
  end

  def entry_for_playlist
    return {:id => id,
            :title => title,
            :album => belongs_to_album,
            :file_path => file_path,
            :duration => duration.to_i
           }
  end
end
