class CreateDefaultSchedule < ActiveRecord::Migration
  def up
    Location.all.each do |location|
      if location.default_schedule.nil?
        schedule = location.schedules.build
        schedule.name = "Default Schedule"
        schedule.save
      end
    end
  end

  def down
  end
end
