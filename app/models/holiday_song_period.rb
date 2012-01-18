class HolidaySongPeriod < ActiveRecord::Base
  belongs_to :location
  after_initialize :default_values

  def default_values
    self.period ||= 5
  end
end
