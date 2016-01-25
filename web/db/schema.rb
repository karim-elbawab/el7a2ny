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

ActiveRecord::Schema.define(version: 20141220065927) do

  create_table "comments", force: true do |t|
    t.integer  "comment_owner"
    t.integer  "group_id"
    t.text     "description"
    t.string   "attach"
    t.integer  "reports"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "private"
    t.string   "attachment"
  end

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "status"
    t.datetime "created_at"
  end

  create_table "invitations", force: true do |t|
    t.string   "user_id"
    t.string   "offer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.integer  "offer_id"
    t.string   "category"
    t.boolean  "seen"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offers", force: true do |t|
    t.string   "name"
    t.string   "photo"
    t.text     "description"
    t.string   "category"
    t.string   "attachment"
    t.integer  "reports"
    t.integer  "notifications"
    t.integer  "admin_id"
    t.boolean  "private"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "attach"
  end

  create_table "posts", force: true do |t|
    t.integer  "owner_id"
    t.string   "description"
    t.integer  "page_user_id"
    t.integer  "reports"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "replies", force: true do |t|
    t.integer  "reply_owner"
    t.integer  "comment_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "country"
    t.date     "birth_date"
    t.string   "profile_picture_url"
    t.string   "gender"
    t.integer  "reports_counter"
    t.string   "encrypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "photo"
  end

end
