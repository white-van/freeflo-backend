# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.


ActiveRecord::Schema.define(version: 2021_01_16_130244) do

  create_table "blacklisted_tokens", force: :cascade do |t|
    t.string "token"
    t.bigint "user_id", null: false
    t.datetime "expire_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_blacklisted_tokens_on_user_id"
  end

  create_table "branches", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_branches_on_project_id"
  end

  create_table "contributions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_contributions_on_project_id"
    t.index ["user_id"], name: "index_contributions_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.bigint "heart_count", default: 0
    t.index ["organization_id"], name: "index_projects_on_organization_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "pull_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "reviewers", array: true
    t.boolean "accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "branch_id"
    t.string "name", null: false
    t.index ["branch_id"], name: "index_pull_requests_on_branch_id"
    t.index ["reviewers"], name: "index_pull_requests_on_reviewers", using: :gin
    t.index ["user_id"], name: "index_pull_requests_on_user_id"
  end

  create_table "refresh_tokens", force: :cascade do |t|
    t.string "token"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_refresh_tokens_on_token", unique: true
    t.index ["user_id"], name: "index_refresh_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "username", null: false
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.string "full_name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pull_request_id"
    t.bigint "branch_id"
    t.index ["branch_id"], name: "index_versions_on_branch_id"
    t.index ["pull_request_id"], name: "index_versions_on_pull_request_id"
    t.index ["user_id"], name: "index_versions_on_user_id"
  end

  add_foreign_key "blacklisted_tokens", "users"
  add_foreign_key "branches", "projects"
  add_foreign_key "contributions", "projects"
  add_foreign_key "contributions", "users"
  add_foreign_key "projects", "organizations"
  add_foreign_key "projects", "users"
  add_foreign_key "pull_requests", "branches"
  add_foreign_key "pull_requests", "users"
  add_foreign_key "refresh_tokens", "users"
  add_foreign_key "users", "organizations"
  add_foreign_key "versions", "branches"
  add_foreign_key "versions", "pull_requests"
  add_foreign_key "versions", "users"
end
