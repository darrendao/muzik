class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.integer :group_id
      t.datetime :date
      t.text :content

      t.timestamps
    end
  end
end
