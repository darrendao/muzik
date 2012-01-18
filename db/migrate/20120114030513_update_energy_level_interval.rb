class UpdateEnergyLevelInterval < ActiveRecord::Migration
  def up
    add_column :energy_level_intervals, :schedule_id, :integer
    add_column :energy_level_intervals, :wday, :integer
    remove_column :energy_level_intervals, :group_id
  end

  def down
    add_column :energy_level_intervals, :group_id, :integer
    remove_column :energy_level_intervals, :schedule_id
    remove_column :energy_level_intervals, :wday
  end
end
