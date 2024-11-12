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

ActiveRecord::Schema[7.2].define(version: 2024_11_11_203358) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image_url"
    t.string "video_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "force"
    t.string "level"
    t.string "mechanic"
    t.string "equipment"
    t.string "category"
    t.text "instructions", default: [], array: true
    t.string "primary_muscles", default: [], array: true
    t.string "secondary_muscles", default: [], array: true
    t.string "images", default: [], array: true
  end

  create_table "routines", force: :cascade do |t|
    t.integer "user_id"
    t.integer "exercise_id"
    t.integer "reps"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sets"
    t.string "day"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workout_logs", force: :cascade do |t|
    t.bigint "routine_id"
    t.boolean "completed"
    t.date "workout_date"
    t.integer "actual_sets"
    t.integer "actual_reps"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["routine_id"], name: "index_workout_logs_on_routine_id"
  end

  add_foreign_key "workout_logs", "routines"
end
