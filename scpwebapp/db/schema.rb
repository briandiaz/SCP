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

ActiveRecord::Schema.define(version: 20141201052101) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cam_locations", force: true do |t|
    t.string   "location"
    t.string   "ip_addres"
    t.string   "mac_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: true do |t|
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["person_id"], name: "index_clients_on_person_id", using: :btree

  create_table "identities", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", force: true do |t|
    t.datetime "time"
    t.integer  "cam_location_id"
    t.integer  "vehicle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "logs", ["cam_location_id"], name: "index_logs_on_cam_location_id", using: :btree
  add_index "logs", ["vehicle_id"], name: "index_logs_on_vehicle_id", using: :btree

  create_table "models", force: true do |t|
    t.string   "name"
    t.integer  "brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "models", ["brand_id"], name: "index_models_on_brand_id", using: :btree

  create_table "people", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "sex"
    t.string   "email"
    t.string   "phone"
    t.string   "mobile"
    t.string   "identification_card"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo"
    t.string   "remote_photo"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "person_id"
    t.integer  "role_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["person_id"], name: "index_users_on_person_id", using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  create_table "vehicles", force: true do |t|
    t.integer  "brand_id"
    t.integer  "model_id"
    t.integer  "year"
    t.string   "color"
    t.text     "special_signs"
    t.string   "plate_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  add_index "vehicles", ["brand_id"], name: "index_vehicles_on_brand_id", using: :btree
  add_index "vehicles", ["model_id"], name: "index_vehicles_on_model_id", using: :btree

  create_table "visitors", force: true do |t|
    t.integer  "person_id"
    t.integer  "vehicle_id"
    t.string   "notes"
    t.datetime "expiring_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visitors", ["person_id"], name: "index_visitors_on_person_id", using: :btree
  add_index "visitors", ["vehicle_id"], name: "index_visitors_on_vehicle_id", using: :btree

end
