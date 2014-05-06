# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140506142022) do

  create_table "decks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "flashcards", force: true do |t|
    t.text     "front"
    t.text     "back"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deck_id"
    t.datetime "due"
    t.integer  "interval"
    t.decimal  "ease_factor"
    t.datetime "last_review"
  end

  add_index "flashcards", ["deck_id"], name: "index_flashcards_on_deck_id"

  create_table "review_logs", force: true do |t|
    t.integer  "deck_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
