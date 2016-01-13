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

ActiveRecord::Schema.define(version: 20121008081509) do

  create_table "invitations", force: :cascade do |t|
    t.integer  "sender_id",       limit: 4
    t.string   "recipient_email", limit: 255
    t.string   "token",           limit: 255
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",            limit: 255
    t.string   "hashed_password",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt",             limit: 255
    t.boolean  "admin"
    t.integer  "height",           limit: 4
    t.boolean  "public"
    t.integer  "invitation_id",    limit: 4
    t.integer  "invitation_limit", limit: 4
    t.decimal  "target",                       precision: 4, scale: 1
  end

  create_table "weighings", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.date     "date"
    t.decimal  "weight",                    precision: 4, scale: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "abdominal_girth", limit: 4
    t.decimal  "adipose",                   precision: 3, scale: 1
  end

end
