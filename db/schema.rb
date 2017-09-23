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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170923210546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "uplink_statuses", force: :cascade do |t|
    t.string "uplink_name", null: false
    t.string "connection_status"
    t.integer "signal_bars"
    t.string "network_type"
    t.string "network_name"
    t.integer "current_connect_time"
    t.integer "current_upload_rate"
    t.integer "current_download_rate"
    t.integer "total_upload"
    t.integer "total_download"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
