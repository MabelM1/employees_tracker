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

ActiveRecord::Schema.define(version: 9) do

  create_table "buildings", force: :cascade do |t|
    t.string "address"
    t.string "super_name"
    t.string "phone_number"
    t.string "user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "work_order_id"
    t.string "employee_id"
    t.string "user_id"
    t.string "subject"
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.string "date_of_birth"
    t.string "email"
    t.string "image"
    t.string "uid"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pay_roles", force: :cascade do |t|
    t.datetime "punch_in"
    t.datetime "punch_out"
    t.string "employee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "replies", force: :cascade do |t|
    t.string "reply"
    t.string "user_id"
    t.string "employee_id"
    t.string "comment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "address"
    t.string "company_name"
    t.string "username"
    t.string "password_digest"
    t.string "licence_number"
    t.string "country"
    t.string "state"
    t.string "email"
    t.string "phone_number"
    t.string "about_us"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "work_orders", force: :cascade do |t|
    t.string "task"
    t.string "comment"
    t.string "phone_number"
    t.datetime "date"
    t.integer "user_id"
    t.integer "building_id"
    t.integer "employee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "status", default: false
  end

end
