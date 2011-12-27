class MediaPlayer < ActiveRecord::Base
  belongs_to :location
  validates :hostname, :uniqueness => true, :presence => true
  validates :serial, :uniqueness => true, :presence => true
  validates :location_id, :uniqueness => true, :unless => :empty_location_id?
  def empty_location_id?
    return location_id.nil?
  end
end
