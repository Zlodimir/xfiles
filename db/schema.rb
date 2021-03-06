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

ActiveRecord::Schema.define(version: 20150407141545) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: :cascade do |t|
    t.string   "asset"
    t.integer  "note_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "assets", ["note_id"], name: "index_assets_on_note_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.integer  "note_id"
    t.integer  "author_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "state_id"
    t.integer  "previous_state_id"
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree
  add_index "comments", ["note_id"], name: "index_comments_on_note_id", using: :btree
  add_index "comments", ["previous_state_id"], name: "index_comments_on_previous_state_id", using: :btree

  create_table "note_watchers", id: false, force: :cascade do |t|
    t.integer "note_id", null: false
    t.integer "user_id", null: false
  end

  add_index "note_watchers", ["note_id", "user_id"], name: "index_note_watchers_on_note_id_and_user_id", using: :btree
  add_index "note_watchers", ["user_id", "note_id"], name: "index_note_watchers_on_user_id_and_note_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "xfile_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "author_id"
    t.integer  "state_id"
  end

  add_index "notes", ["xfile_id"], name: "index_notes_on_xfile_id", using: :btree

  create_table "notes_tags", id: false, force: :cascade do |t|
    t.integer "tag_id",  null: false
    t.integer "note_id", null: false
  end

  add_index "notes_tags", ["note_id", "tag_id"], name: "index_notes_tags_on_note_id_and_tag_id", using: :btree
  add_index "notes_tags", ["tag_id", "note_id"], name: "index_notes_tags_on_tag_id_and_note_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "role"
    t.integer  "xfile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "roles", ["user_id"], name: "index_roles_on_user_id", using: :btree
  add_index "roles", ["xfile_id"], name: "index_roles_on_xfile_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.string   "color"
    t.string   "background"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "default",    default: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "xfiles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "assets", "notes"
  add_foreign_key "comments", "notes"
  add_foreign_key "comments", "states", column: "previous_state_id"
  add_foreign_key "comments", "users", column: "author_id"
  add_foreign_key "notes", "xfiles"
  add_foreign_key "roles", "users"
  add_foreign_key "roles", "xfiles"
end
