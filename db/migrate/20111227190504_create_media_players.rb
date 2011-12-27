class CreateMediaPlayers < ActiveRecord::Migration
  def change
    create_table :media_players do |t|
      t.integer :location_id
      t.string :ip_address
      t.string :hostname
      t.string :serial

      t.timestamps
    end
  end
end
