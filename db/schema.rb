# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141113123518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.string   "description"
  end

  create_table "routes", force: true do |t|
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "way"
  end

  add_index "routes", ["address_id"], name: "index_routes_on_address_id", using: :btree

  create_table "schools", force: true do |t|
    t.string   "name"
    t.integer  "address_id"
    t.float    "arrival"
    t.float    "departure"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schools", ["address_id"], name: "index_schools_on_address_id", using: :btree

  create_table "startpoints", force: true do |t|
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "startpoints", ["address_id"], name: "index_startpoints_on_address_id", using: :btree

  create_table "students", force: true do |t|
    t.string   "name"
    t.integer  "address_id"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "turn"
  end

  add_index "students", ["address_id"], name: "index_students_on_address_id", using: :btree
  add_index "students", ["school_id"], name: "index_students_on_school_id", using: :btree

end
