class CreateEnergyLevels < ActiveRecord::Migration
  def change
    create_table :energy_levels do |t|
      t.string  :name
      t.integer :elevel
      t.timestamps
    end
  end
end
