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

ActiveRecord::Schema.define(version: 20130730145125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "blocked_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "blocked_user_id"
    t.boolean  "blocked"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blocked_users", ["user_id", "blocked_user_id"], name: "index_blocked_users_on_user_id_and_blocked_user_id", unique: true, using: :btree

  create_table "experiences", primary_key: "experience_id", force: true do |t|
    t.datetime "date"
    t.integer  "moment",           default: -1
    t.string   "location"
    t.integer  "place",            default: -1
    t.integer  "detail_one",       default: -1
    t.integer  "detail_two",       default: -1
    t.integer  "detail_three",     default: -1
    t.integer  "hairdressing",     default: -1
    t.integer  "kiss",             default: -1
    t.integer  "oral_sex",         default: -1
    t.integer  "intercourse",      default: -1
    t.integer  "caresses",         default: -1
    t.integer  "anal_sex",         default: -1
    t.integer  "post_intercourse", default: -1
    t.integer  "repeat",           default: -1
    t.integer  "visibility",       default: -1
    t.integer  "times",            default: -1
    t.integer  "personal_score",   default: 0
    t.integer  "msd_score",        default: 0
    t.integer  "final_score",      default: 0
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
    t.boolean  "pending",               default: true
    t.boolean  "secret_lover_ask",      default: false
    t.boolean  "secret_lover_accepted", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true, using: :btree

  create_table "geosexes", primary_key: "user_id", force: true do |t|
    t.integer  "access",     default: 0
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
    t.integer  "age",         default: 0
    t.integer  "sex_gender",  default: 0
    t.integer  "job",         default: 0
    t.integer  "height",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", primary_key: "photo_id", force: true do |t|
    t.string   "name"
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

  create_table "user_photos", force: true do |t|
    t.integer "user_id"
    t.integer "photo_id"
  end

  create_table "users", primary_key: "user_id", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "facebook_id"
    t.string   "remember_token"
    t.string   "password_digest"
    t.integer  "status",          default: 0
    t.string   "facebook_photo"
    t.integer  "profile_photo",   default: -1
    t.integer  "photo_num",       default: 1
    t.integer  "lovers_num",      default: 0
    t.integer  "job",             default: 0
    t.integer  "age",             default: 0
    t.datetime "birthday"
    t.datetime "startday"
    t.integer  "eye_color",       default: 0
    t.integer  "hair_color",      default: 0
    t.integer  "height",          default: 0
    t.integer  "hairdressing",    default: 0
    t.integer  "sex_interest",    default: 0
    t.integer  "sex_gender",      default: 0
    t.integer  "preferences",                     array: true
    t.boolean  "admin",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
