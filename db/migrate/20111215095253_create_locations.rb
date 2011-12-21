class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.string :phone_number
      t.string :contact_name
      t.integer :group_id
      t.timestamps
    end
  end
end
