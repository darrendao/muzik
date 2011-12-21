class BusinessHour < ActiveRecord::Base
  belongs_to :schedulable, :polymorphic => true
  def initialize(*args)
    super(*args)
    if wday && wday !~ /\d/
      puts "IT wAS #{wday}"
      wday = Date::ABBR_DAYNAMES.index(wday)

      puts "IT IS NOW #{wday}"
    end
  end
  def self.day_options
    day_options = []
    Date::ABBR_DAYNAMES.each_with_index do|x,y|
      day_options << [x, y]
    end
    day_options
  end
end
