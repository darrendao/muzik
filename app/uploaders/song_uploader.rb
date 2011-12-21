# encoding: utf-8
require 'mp3info'
class SongUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    #"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Only allow mp3 files to be uploaded for songs
  def extension_white_list
    %w(mp3)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def populate_mp3_info
    puts "MODEL IS #{model.inspect}"
    Mp3Info.open(current_path) do |mp3|
      puts "TITLE WAS #{model.title}"
      model.title = mp3.tag.title
      puts "TITLE IS #{model.title}"
      model.artist = mp3.tag.artist
#      model.album = mp3.tag.album
      model.length = mp3.length
    end
    model.checksum = Digest::MD5.file(current_path).hexdigest
  end

  process :populate_mp3_info
end
