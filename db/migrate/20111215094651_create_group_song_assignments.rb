class CreateGroupSongAssignments < ActiveRecord::Migration
  def change
    create_table :group_song_assignments do |t|
      t.integer :song_id
      t.integer :group_id
      t.string :energy_level
      t.timestamps
    end
  end
end
