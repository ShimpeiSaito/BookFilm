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

ActiveRecord::Schema.define(version: 2022_01_12_150500) do

  create_table "admins", force: :cascade do |t|
    t.string "login_id", null: false
    t.string "name", null: false
    t.date "birthday", null: false
    t.string "tel", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "members", force: :cascade do |t|
    t.string "login_id", null: false
    t.string "name", null: false
    t.date "birthday", null: false
    t.string "tel", null: false
    t.string "email", null: false
    t.string "payment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title", null: false
    t.text "explanation", null: false
    t.date "released_at", null: false
    t.date "expired_at", null: false
    t.integer "screening_time", null: false
    t.text "distribution"
    t.string "director"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservationdetails", force: :cascade do |t|
    t.integer "reservation_id", null: false
    t.integer "ticket_id"
    t.string "seat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_id"], name: "index_reservationdetails_on_reservation_id"
    t.index ["ticket_id"], name: "index_reservationdetails_on_ticket_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "schedule_id", null: false
    t.string "payment", null: false
    t.integer "ticket_sheets"
    t.integer "total_sheets"
    t.datetime "confirm_time"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_reservations_on_member_id"
    t.index ["schedule_id"], name: "index_reservations_on_schedule_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "theater_id", null: false
    t.integer "movie_id", null: false
    t.integer "screen_no", null: false
    t.date "screening_date", null: false
    t.datetime "starttime", null: false
    t.datetime "endtime", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_schedules_on_movie_id"
    t.index ["theater_id"], name: "index_schedules_on_theater_id"
  end

  create_table "screens", force: :cascade do |t|
    t.integer "screen_no", null: false
    t.integer "theater_id", null: false
    t.integer "seat_group", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["theater_id"], name: "index_screens_on_theater_id"
  end

  create_table "seats", force: :cascade do |t|
    t.integer "seat_group", null: false
    t.string "row", null: false
    t.integer "start_line", null: false
    t.integer "last_line", null: false
    t.integer "num", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "theaters", force: :cascade do |t|
    t.string "store_name", null: false
    t.string "address", null: false
    t.string "tel", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string "t_type", null: false
    t.integer "total", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
