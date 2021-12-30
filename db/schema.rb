# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_23_185435) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "paragraphs", force: :cascade do |t|
    t.text "content"
    t.integer "level", default: 1
    t.text "address"
    t.integer "likes_count", default: 0
    t.integer "dislikes_count", default: 0
    t.integer "score", default: 0
    t.bigint "user_id", null: false
    t.bigint "story_id", null: false
    t.bigint "previous_paragraph_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["previous_paragraph_id"], name: "index_paragraphs_on_previous_paragraph_id"
    t.index ["story_id"], name: "index_paragraphs_on_story_id"
    t.index ["user_id"], name: "index_paragraphs_on_user_id"
  end

  create_table "reactions", force: :cascade do |t|
    t.boolean "like"
    t.bigint "paragraph_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["like"], name: "index_reactions_on_like"
    t.index ["paragraph_id"], name: "index_reactions_on_paragraph_id"
    t.index ["user_id"], name: "index_reactions_on_user_id"
  end

  create_table "stories", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.boolean "bot", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at", precision: 6
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "paragraphs", "paragraphs", column: "previous_paragraph_id"
  add_foreign_key "paragraphs", "stories"
  add_foreign_key "paragraphs", "users"
  add_foreign_key "reactions", "paragraphs"
  add_foreign_key "reactions", "users"
end
