class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.integer :location_id

      t.timestamps
    end
  end
end
