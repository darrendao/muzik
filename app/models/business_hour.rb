class BusinessHour < ActiveRecord::Base
  belongs_to :schedulable, :polymorphic => true
  default_scope :order => 'business_hours.wday'
  def initialize(*args)
    super(*args)
    if wday && wday !~ /\d/
      wday = Date::ABBR_DAYNAMES.index(wday)
    end
  end
  def self.day_options
    day_options = []
    Date::ABBR_DAYNAMES.each_with_index do|x,y|
      day_options << [x, y]
    end
    day_options
  end

  def open_at_str
    open_at ? open_at.strftime("%H:%M") : ""
  end
  def close_at_str
    close_at ? close_at.strftime("%H:%M") : ""
  end
end
