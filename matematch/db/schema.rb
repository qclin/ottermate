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

ActiveRecord::Schema.define(version: 20150529014249) do

  create_table "chats", force: :cascade do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.string   "msg"
    t.boolean  "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "endorsements", force: :cascade do |t|
    t.integer  "endorser_id"
    t.integer  "endorsee_id"
    t.string   "skill"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "room_id"
    t.integer  "reviewer_id"
    t.string   "comment"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "description"
    t.integer  "price"
    t.string   "photo_url"
    t.string   "neighborhood"
    t.boolean  "petfriendly"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "gender"
    t.boolean  "hasRoom"
    t.string   "personality"
    t.string   "occupation"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "description"
    t.float    "reliability"
    t.string   "watsonfeed"
    t.string   "username"
    t.integer  "budget"
  end

end
