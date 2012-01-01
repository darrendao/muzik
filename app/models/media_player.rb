class MediaPlayer < ActiveRecord::Base
  belongs_to :location
  validates :hostname, :uniqueness => true
  validates :serial, :uniqueness => true, :unless => :empty_serial?
  validates :location_id, :uniqueness => true, :unless => :empty_location_id?

  def empty_location_id?
    return location_id.nil?
  end

  def empty_serial?
    return (serial.nil? or serial.empty?)
  end
  def portal_url
    if ip_address && !ip_address.empty?
      return "http://#{ip_address}/status"
    else
      return nil
    end
  end
end
