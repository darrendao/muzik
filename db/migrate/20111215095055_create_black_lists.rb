class CreateBlackLists < ActiveRecord::Migration
  def change
    create_table :black_lists do |t|
      t.integer :location_id
      t.integer :song_id

      t.timestamps
    end
  end
end
