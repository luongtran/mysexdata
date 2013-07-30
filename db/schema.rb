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

ActiveRecord::Schema.define(version: 20130716080607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "experiences", primary_key: "experience_id", force: true do |t|
    t.datetime "date"
    t.integer  "moment"
    t.string   "location"
    t.integer  "place"
    t.integer  "detail_one"
    t.integer  "detail_two"
    t.integer  "detail_three"
    t.integer  "hairdressing"
    t.integer  "kiss"
    t.integer  "oral_sex"
    t.integer  "intercourse"
    t.integer  "caresses"
    t.integer  "anal_sex"
    t.integer  "post_intercourse"
    t.integer  "personal_score"
    t.integer  "repeat"
    t.float    "msd_score"
    t.integer  "bad_lover"
    t.integer  "final_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "external_invitations", force: true do |t|
    t.integer  "sender_id"
    t.string   "receiver"
    t.string   "facebook_id"
    t.string   "name"
    t.string   "photo_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "external_invitations", ["sender_id", "facebook_id"], name: "index_external_invitations_on_sender_id_and_facebook_id", unique: true, using: :btree

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.boolean  "accepted",              default: false
    t.boolean  "pending",               default: false
    t.boolean  "secret_lover_ask",      default: false
    t.boolean  "secret_lover_accepted", default: false
    t.boolean  "blecked",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true, using: :btree

  create_table "geosexes", primary_key: "user_id", force: true do |t|
    t.integer  "access",     default: 0
    t.integer  "status",     default: 0
    t.float    "lat"
    t.float    "lng"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "geosexes", ["user_id"], name: "index_geosexes_on_user_id", using: :btree

  create_table "lover_experiences", force: true do |t|
    t.integer "lover_id"
    t.integer "experience_id"
  end

  add_index "lover_experiences", ["lover_id", "experience_id"], name: "index_lover_experiences_on_lover_id_and_experience_id", unique: true, using: :btree

  create_table "lovers", primary_key: "lover_id", force: true do |t|
    t.string   "facebook_id"
    t.string   "name"
    t.string   "photo_url"
    t.integer  "age",         default: -1
    t.integer  "sex_gender",  default: -1
    t.integer  "job",         default: -1
    t.integer  "height",      default: -1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lovers", ["facebook_id"], name: "index_lovers_on_facebook_id", unique: true, using: :btree

  create_table "messages", primary_key: "message_id", force: true do |t|
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", primary_key: "photo_id", force: true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_lovers", force: true do |t|
    t.integer "user_id"
    t.integer "lover_id"
    t.integer "visibility", default: 0
    t.boolean "pending",    default: false
  end

  add_index "user_lovers", ["user_id", "lover_id"], name: "index_user_lovers_on_user_id_and_lover_id", unique: true, using: :btree

  create_table "user_photos", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "photo_id"
  end

  create_table "users", primary_key: "user_id", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "facebook_id"
    t.string   "remember_token"
    t.string   "password_digest"
    t.string   "password"
    t.integer  "status"
    t.string   "main_photo_url"
    t.integer  "photo_num"
    t.integer  "lovers_num",      default: 0
    t.integer  "job"
    t.integer  "age"
    t.datetime "startday"
    t.integer  "eye_color"
    t.integer  "hair_color"
    t.integer  "height"
    t.integer  "hairdressing"
    t.integer  "sex_interest"
    t.integer  "sex_gender"
    t.integer  "preferences",                     array: true
    t.boolean  "admin",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
