# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_04_06_054019) do
  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "date"
    t.string "location"
    t.integer "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_events_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "admin_user_id"
  end

  create_table "seats", force: :cascade do |t|
    t.integer "event_id", null: false
    t.string "seat_row"
    t.string "seat_number"
    t.decimal "price"
    t.boolean "reserved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_seats_on_event_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "seat_row"
    t.string "seat_number"
    t.decimal "price", precision: 8, scale: 2
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "seat_id"
    t.index ["event_id"], name: "index_tickets_on_event_id"
    t.index ["seat_id"], name: "index_tickets_on_seat_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "auth_token"
  end

  add_foreign_key "events", "organizations"
  add_foreign_key "seats", "events"
  add_foreign_key "tickets", "events"
  add_foreign_key "tickets", "seats"
  add_foreign_key "tickets", "users"
end
