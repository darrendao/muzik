class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :artist
      t.decimal :duration
      t.string :checksum
      t.string :file_path
      t.string :album
      t.timestamps
    end
  end
end
