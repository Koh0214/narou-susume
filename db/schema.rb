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

ActiveRecord::Schema.define(version: 2018_08_09_093513) do

  create_table "comments", force: :cascade do |t|
    t.string "name"
    t.text "comment"
    t.integer "up"
    t.integer "down"
    t.integer "novel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["novel_id"], name: "index_comments_on_novel_id"
  end

  create_table "novels", force: :cascade do |t|
    t.text "title"
    t.text "description"
    t.text "url"
    t.integer "like"
    t.integer "osusume_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["osusume_id"], name: "index_novels_on_osusume_id"
  end

  create_table "osusumes", force: :cascade do |t|
    t.string "title"
    t.string "short_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string "name"
    t.text "text"
    t.integer "like"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "novel_id"
    t.index ["novel_id"], name: "index_reviews_on_novel_id"
  end

end
