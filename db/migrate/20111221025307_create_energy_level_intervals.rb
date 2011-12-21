class CreateEnergyLevelIntervals < ActiveRecord::Migration
  def change
    create_table :energy_level_intervals do |t|
      t.integer :group_id
      t.integer :energy_level_id
      t.time :start_at
      t.time :end_at
      t.timestamps
    end
  end
end
