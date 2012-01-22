class Schedule < ActiveRecord::Base
  belongs_to :location
  scope :special, where("name != ?", ['Default Schedule'])
  has_many :energy_level_intervals, :dependent => :destroy

  def energy_level_intervals_by_wday
    result = {}
    energy_level_intervals.each do |eli|
      result[eli.wday] ||= []
      result[eli.wday] << eli
    end
    result
  end

  def is_default?
    name == 'Default Schedule' ? true :false
  end
end
