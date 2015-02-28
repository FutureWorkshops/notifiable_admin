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

ActiveRecord::Schema.define(version: 20150221010358) do

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.datetime "locked_at"
    t.string   "role"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "admins_notifiable_apps", force: true do |t|
    t.integer "admin_id"
    t.integer "app_id"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",        default: 0, null: false
    t.integer  "attempts",        default: 0, null: false
    t.text     "handler",                     null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.integer  "notification_id"
    t.integer  "app_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "notifiable_apps", force: true do |t|
    t.string   "name"
    t.text     "configuration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  create_table "notifiable_apps_notifications_api_users", force: true do |t|
    t.integer "app_id"
    t.integer "notifications_api_user_id"
  end

  create_table "notifiable_device_tokens", force: true do |t|
    t.string   "token"
    t.string   "provider"
    t.string   "locale"
    t.boolean  "is_valid",   default: true
    t.integer  "user_id"
    t.integer  "app_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifiable_device_tokens", ["token"], name: "index_notifiable_device_tokens_on_token", unique: true
  add_index "notifiable_device_tokens", ["user_id"], name: "index_notifiable_device_tokens_on_user_id"

  create_table "notifiable_localized_notifications", force: true do |t|
    t.text     "message"
    t.text     "params"
    t.string   "locale"
    t.integer  "notification_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifiable_notifications", force: true do |t|
    t.integer  "app_id"
    t.integer  "sent_count",             default: 0
    t.integer  "gateway_accepted_count", default: 0
    t.integer  "opened_count",           default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifiable_statuses", force: true do |t|
    t.integer  "localized_notification_id"
    t.integer  "device_token_id"
    t.integer  "status"
    t.datetime "created_at"
  end

  create_table "notifications_api_users", force: true do |t|
    t.string   "service_name",       default: "", null: false
    t.integer  "sign_in_count",      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",    default: 0,  null: false
    t.datetime "locked_at"
    t.string   "access_id"
    t.string   "secret_key"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications_api_users", ["access_id"], name: "index_notifications_api_users_on_access_id", unique: true
  add_index "notifications_api_users", ["secret_key"], name: "index_notifications_api_users_on_secret_key", unique: true

  create_table "users", force: true do |t|
    t.string "alias", null: false
  end

  add_index "users", ["alias"], name: "index_users_on_alias", unique: true

end
