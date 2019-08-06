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

ActiveRecord::Schema.define(version: 2019_07_28_145409) do

  create_table "items", force: :cascade do |t|
    t.string "item_title"
    t.string "item_url"
    t.integer "item_price"
    t.integer "item_good"
    t.string "item_type"
    t.string "item_category"
    t.string "item_brand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "item_image1"
    t.string "item_image2"
    t.string "item_image3"
    t.string "item_image4"
    t.string "item_image5"
    t.string "item_image6"
    t.string "item_image7"
    t.string "item_image8"
    t.string "item_image9"
    t.string "item_image10"
    t.string "item_postage"
    t.string "item_description"
    t.string "item_days_to_ship"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
