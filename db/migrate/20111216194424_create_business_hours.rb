class CreateBusinessHours < ActiveRecord::Migration
  def change
    create_table :business_hours do |t|
      t.string :schedulable_type
      t.integer :schedulable_id
      t.integer :wday
      t.time :open_at
      t.time :close_at

      t.timestamps
    end
  end
end
