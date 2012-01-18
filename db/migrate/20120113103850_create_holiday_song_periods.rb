class CreateHolidaySongPeriods < ActiveRecord::Migration
  def change
    create_table :holiday_song_periods do |t|
      t.integer :location_id
      t.integer :period

      t.timestamps
    end
  end
end
