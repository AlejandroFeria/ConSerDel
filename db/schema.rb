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

ActiveRecord::Schema.define(version: 2021_03_14_041947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "delivery_config_values", force: :cascade do |t|
    t.bigint "delivery_service_auth_key_id"
    t.bigint "delivery_service_account_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delivery_service_account_id"], name: "index_delivery_config_values_on_delivery_service_account_id"
    t.index ["delivery_service_auth_key_id"], name: "index_delivery_config_values_on_delivery_service_auth_key_id"
  end

  create_table "delivery_service_accounts", force: :cascade do |t|
    t.bigint "delivery_service_catalogue_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delivery_service_catalogue_id"], name: "delivery_service_catalogue"
  end

  create_table "delivery_service_auth_keys", force: :cascade do |t|
    t.bigint "delivery_service_catalogue_id"
    t.string "var_name"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delivery_service_catalogue_id"], name: "delivery_service_catalogue_id"
  end

  create_table "delivery_service_catalogues", force: :cascade do |t|
    t.string "var_name"
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "request_trackings", force: :cascade do |t|
    t.bigint "delivery_service_catalogue_id"
    t.string "number"
    t.string "status_name"
    t.string "status_var_name"
    t.boolean "active"
    t.integer "condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delivery_service_catalogue_id"], name: "index_request_trackings_on_delivery_service_catalogue_id"
  end

  create_table "service_status_catalogues", force: :cascade do |t|
    t.string "name"
    t.string "var_name"
    t.string "status_equivalences"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracking_request_statuses", force: :cascade do |t|
    t.bigint "request_tracking_id"
    t.bigint "service_status_catalogue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_tracking_id"], name: "index_tracking_request_statuses_on_request_tracking_id"
    t.index ["service_status_catalogue_id"], name: "index_tracking_request_statuses_on_service_status_catalogue_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "delivery_config_values", "delivery_service_accounts"
  add_foreign_key "delivery_config_values", "delivery_service_auth_keys"
  add_foreign_key "delivery_service_accounts", "delivery_service_catalogues"
  add_foreign_key "delivery_service_auth_keys", "delivery_service_catalogues"
  add_foreign_key "request_trackings", "delivery_service_catalogues"
  add_foreign_key "tracking_request_statuses", "request_trackings"
  add_foreign_key "tracking_request_statuses", "service_status_catalogues"
end
