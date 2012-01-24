# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120119215721) do

  create_table "black_lists", :force => true do |t|
    t.integer  "location_id"
    t.integer  "song_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_hours", :force => true do |t|
    t.string   "schedulable_type"
    t.integer  "schedulable_id"
    t.integer  "wday"
    t.time     "open_at"
    t.time     "close_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "energy_level_intervals", :force => true do |t|
    t.integer  "energy_level_id"
    t.time     "start_at"
    t.time     "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "schedule_id"
    t.integer  "wday"
  end

  create_table "energy_levels", :force => true do |t|
    t.string   "name"
    t.integer  "elevel"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_holiday_schedules", :force => true do |t|
    t.integer  "group_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_song_assignments", :force => true do |t|
    t.integer  "song_id"
    t.integer  "group_id"
    t.integer  "energy_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holiday_song_periods", :force => true do |t|
    t.integer  "location_id"
    t.integer  "period"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "address"
    t.string   "phone_number"
    t.string   "contact_name"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "media_players", :force => true do |t|
    t.integer  "location_id"
    t.string   "ip_address"
    t.string   "hostname"
    t.string   "serial"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "playlists", :force => true do |t|
    t.integer  "group_id"
    t.date     "date"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_holiday"
  end

  create_table "songs", :force => true do |t|
    t.string   "belongs_to_album"
    t.string   "title"
    t.string   "artist"
    t.decimal  "duration"
    t.string   "checksum"
    t.string   "file_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mp3_file_name"
    t.string   "mp3_content_type"
    t.integer  "mp3_file_size"
    t.datetime "mp3_updated_at"
    t.string   "itunes_persistent_id"
  end

  add_index "songs", ["itunes_persistent_id"], :name => "index_songs_on_itunes_persistent_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tests", :force => true do |t|
    t.string   "hello"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
