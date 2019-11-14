# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_13_163417) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "board_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "board_id", null: false
    t.boolean "admin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["board_id"], name: "index_board_users_on_board_id"
    t.index ["user_id"], name: "index_board_users_on_user_id"
  end

  create_table "boards", force: :cascade do |t|
    t.string "place"
    t.string "title"
    t.string "description"
    t.string "current_weather"
    t.string "current_exchange_rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "country"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.float "ne_lat"
    t.float "ne_lng"
    t.float "sw_lat"
    t.float "sw_lng"
    t.string "level"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "connections", force: :cascade do |t|
    t.bigint "user_one_id"
    t.bigint "user_two_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_one_id"], name: "index_connections_on_user_one_id"
    t.index ["user_two_id"], name: "index_connections_on_user_two_id"
  end

  create_table "country_codes", force: :cascade do |t|
    t.string "country"
    t.string "country_code"
    t.string "currency_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "day_schedule_items", force: :cascade do |t|
    t.bigint "experience_id", null: false
    t.bigint "day_schedule_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["day_schedule_id"], name: "index_day_schedule_items_on_day_schedule_id"
    t.index ["experience_id"], name: "index_day_schedule_items_on_experience_id"
  end

  create_table "day_schedules", force: :cascade do |t|
    t.date "date"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "board_id", null: false
    t.index ["board_id"], name: "index_day_schedules_on_board_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.string "longitude"
    t.string "latitude"
    t.string "title"
    t.string "description"
    t.string "photo"
    t.bigint "board_id", null: false
    t.integer "vote", default: 0
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "address"
    t.integer "rating"
    t.string "opening_hours"
    t.string "price_level"
    t.string "phone_number"
    t.string "website"
    t.string "google_url"
    t.index ["board_id"], name: "index_experiences_on_board_id"
    t.index ["category_id"], name: "index_experiences_on_category_id"
    t.index ["user_id"], name: "index_experiences_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "home_location"
    t.string "string"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.string "votable_type"
    t.bigint "votable_id"
    t.string "voter_type"
    t.bigint "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter_type_and_voter_id"
  end

  add_foreign_key "board_users", "boards"
  add_foreign_key "board_users", "users"
  add_foreign_key "connections", "users", column: "user_one_id"
  add_foreign_key "connections", "users", column: "user_two_id"
  add_foreign_key "day_schedule_items", "day_schedules"
  add_foreign_key "day_schedule_items", "experiences"
  add_foreign_key "day_schedules", "boards"
  add_foreign_key "experiences", "boards"
  add_foreign_key "experiences", "categories"
  add_foreign_key "experiences", "users"
end
