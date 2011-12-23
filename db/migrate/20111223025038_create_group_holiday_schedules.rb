class CreateGroupHolidaySchedules < ActiveRecord::Migration
  def change
    create_table :group_holiday_schedules do |t|
      t.integer :group_id
      t.datetime :start_date
      t.datetime :end_date
      t.string :name

      t.timestamps
    end
  end
end
