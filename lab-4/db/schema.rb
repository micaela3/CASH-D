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

ActiveRecord::Schema.define(version: 2021_11_13_213942) do

  create_table "courses", force: :cascade do |t|
    t.string "course_description"
    t.string "course_title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "course_number"
  end

  create_table "instructors", force: :cascade do |t|
    t.string "instructor_name"
    t.string "instructor_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "meeting_id"
    t.index ["meeting_id"], name: "index_instructors_on_meeting_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.time "start_time"
    t.time "end_time"
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.boolean "saturday"
    t.boolean "sunday"
    t.string "location"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "section_id"
    t.index ["section_id"], name: "index_meetings_on_section_id"
  end

  create_table "recommendations", force: :cascade do |t|
    t.integer "grader_id"
    t.integer "instructor_id"
    t.string "course"
    t.string "section"
    t.string "comments"
  end

  create_table "sections", force: :cascade do |t|
    t.integer "section_number"
    t.integer "class_number"
    t.string "component"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "course_id"
    t.integer "grader_id"
    t.index ["course_id"], name: "index_sections_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
