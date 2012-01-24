class AddIsHolidayToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :is_holiday, :boolean
  end
end
