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

ActiveRecord::Schema.define(version: 20150829182457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abuse_reports", force: :cascade do |t|
    t.string   "status"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "offender_id_id"
    t.integer  "reporter_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations_users", id: false, force: :cascade do |t|
    t.integer "conversation_id", null: false
    t.integer "user_id",         null: false
  end

  add_index "conversations_users", ["conversation_id"], name: "index_conversations_users_on_conversation_id", using: :btree
  add_index "conversations_users", ["user_id"], name: "index_conversations_users_on_user_id", using: :btree

  create_table "extended_profile_language", id: false, force: :cascade do |t|
    t.integer "extended_profile_id", null: false
    t.integer "language_id",         null: false
  end

  add_index "extended_profile_language", ["extended_profile_id"], name: "index_extended_profile_language_on_extended_profile_id", using: :btree
  add_index "extended_profile_language", ["language_id"], name: "index_extended_profile_language_on_language_id", using: :btree

  create_table "extended_profiles", force: :cascade do |t|
    t.text     "skill_level"
    t.text     "special_interests"
    t.text     "availability"
    t.text     "time_zone"
    t.text     "notes"
    t.boolean  "is_mentor"
    t.boolean  "is_pair_partner"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "extended_profiles_languages", force: :cascade do |t|
    t.integer "extended_profile_id"
    t.integer "language_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.string   "invitee_email"
    t.text     "message"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.boolean  "is_read",         default: false
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "conversation_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "full_name"
    t.text     "description"
    t.string   "homepages"
    t.string   "language"
    t.string   "repo_url"
    t.string   "remote_id"
    t.boolean  "has_coc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "homepage"
  end

  create_table "projects_users", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string   "email"
    t.boolean  "synced_to_mailchimp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "twitter_handle"
    t.string   "github_username"
    t.boolean  "accepts_coc"
    t.boolean  "accepts_terms"
    t.boolean  "subscribed"
    t.boolean  "is_frozen"
    t.boolean  "is_admin"
    t.string   "email",                                       null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string   "last_login_from_ip_address"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.integer  "failed_logins_count",             default: 0
    t.datetime "lock_expires_at"
    t.string   "unlock_token"
    t.string   "username"
    t.boolean  "subscribe_me"
  end

  add_index "users", ["activation_token"], name: "index_users_on_activation_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["last_logout_at", "last_activity_at"], name: "index_users_on_last_logout_at_and_last_activity_at", using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", using: :btree

end
