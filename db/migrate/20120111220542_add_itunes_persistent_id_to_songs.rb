class AddItunesPersistentIdToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :itunes_persistent_id, :string
    add_index :songs, :itunes_persistent_id
  end
end
