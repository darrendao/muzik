class MediaPlayer < ActiveRecord::Base
  belongs_to :location
  validates :hostname, :uniqueness => true, :presence => true
  validates :serial, :uniqueness => true, :presence => true
  validates :location_id, :uniqueness => true, :unless => :empty_location_id?
  def empty_location_id?
    return location_id.nil?
  end
  def portal_url
    if ip_address && !ip_address.empty?
      return "http://#{ip_address}/status"
    else
      return nil
    end
  end
end
