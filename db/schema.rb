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

ActiveRecord::Schema.define(version: 2023_08_10_000021) do

  create_table "members", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_members_on_room_id"
    t.index ["user_id", "room_id"], name: "index_members_on_user_id_and_room_id", unique: true
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "room_id", null: false
    t.integer "user_id", null: false
    t.string "content"
    t.integer "phase", limit: 1, default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_questions_on_room_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "title", null: false
    t.string "password", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.integer "hero_id"
    t.index ["hero_id"], name: "index_rooms_on_hero_id"
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "members", "rooms"
  add_foreign_key "members", "users"
  add_foreign_key "questions", "rooms"
  add_foreign_key "questions", "users"
  add_foreign_key "rooms", "users"
  add_foreign_key "rooms", "users", column: "hero_id"
end