class CreateGroupSongAssignments < ActiveRecord::Migration
  def change
    create_table :group_song_assignments do |t|
      t.integer :song_id
      t.integer :group_id
      t.integer :energy_level_id
      t.timestamps
    end
  end
end
