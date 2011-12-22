require 'mp3info'
class Song < ActiveRecord::Base
  #attr_accessible :file_path, :checksum, :title, :artist, :length, :energy_level, :created_at, :updated_at
  #mount_uploader :file_path, SongUploader
  has_attached_file :mp3
  before_post_process :process_mp3

  def process_mp3
    tmp_path = mp3.queued_for_write[:original].path
    Mp3Info.open(tmp_path) do |mp3_info|
      self.title = mp3_info.tag.title
      self.artist = mp3_info.tag.artist
      self.duration = mp3_info.length
      self.belongs_to_album = mp3_info.tag.album
    end
    self.checksum = Digest::MD5.file(tmp_path).hexdigest
  end
end
