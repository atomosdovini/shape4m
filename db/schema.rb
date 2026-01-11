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

ActiveRecord::Schema[7.1].define(version: 2026_01_11_024328) do
  create_table "daily_logs", force: :cascade do |t|
    t.date "date"
    t.decimal "weight_kg"
    t.decimal "waist_cm"
    t.boolean "hit_protein"
    t.boolean "hit_calories"
    t.boolean "hit_steps"
    t.boolean "did_workout"
    t.boolean "hit_water"
    t.boolean "hit_sleep"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_daily_logs_on_user_id"
  end

  create_table "plan_configurations", force: :cascade do |t|
    t.json "data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_plan_configurations_on_user_id"
  end

  create_table "routine_logs", force: :cascade do |t|
    t.date "date"
    t.string "key"
    t.boolean "done"
    t.datetime "done_at"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_routine_logs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "daily_logs", "users"
  add_foreign_key "plan_configurations", "users"
  add_foreign_key "routine_logs", "users"
end
