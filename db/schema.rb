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

ActiveRecord::Schema.define(version: 20190814073337) do

  create_table "ads", force: :cascade do |t|
    t.integer  "seller_id"
    t.string   "link"
    t.float    "price"
    t.string   "place"
    t.date     "ad_date"
    t.integer  "views"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seller_id"], name: "index_ads_on_seller_id"
  end

  create_table "autos", force: :cascade do |t|
    t.integer  "ad_id"
    t.string   "full_name"
    t.string   "brand"
    t.string   "model"
    t.integer  "year"
    t.string   "mileage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_id"], name: "index_autos_on_ad_id"
    t.index ["brand"], name: "index_autos_on_brand"
  end

  create_table "sellers", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
