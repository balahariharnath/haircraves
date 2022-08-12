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

ActiveRecord::Schema[7.0].define(version: 2022_08_12_094856) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "door_no"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "pincode"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_addresses_on_deleted_at"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "appointment_services", force: :cascade do |t|
    t.bigint "appointment_id", null: false
    t.bigint "service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appointment_id"], name: "index_appointment_services_on_appointment_id"
    t.index ["service_id"], name: "index_appointment_services_on_service_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.date "booking_date"
    t.string "reason_for_cancel"
    t.integer "status"
    t.time "time"
    t.boolean "paid", default: false
    t.float "sub_total"
    t.float "tax"
    t.float "total"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "stylist_id"
    t.index ["stylist_id"], name: "index_appointments_on_stylist_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "availabilities", force: :cascade do |t|
    t.string "day"
    t.boolean "active", default: false
    t.time "start_time"
    t.time "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_availabilities_on_user_id"
  end

  create_table "banks", force: :cascade do |t|
    t.string "account_holder_name"
    t.string "account_number"
    t.string "routing_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.string "card_number"
    t.string "card_holder_name"
    t.string "exp_date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_cards_on_deleted_at"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "cart_products", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.bigint "item_id", null: false
    t.integer "qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_products_on_cart_id"
    t.index ["item_id"], name: "index_cart_products_on_item_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "sub_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "message"
    t.bigint "user_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.string "convo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sender_id"
    t.integer "receiver_id"
  end

  create_table "device_infos", force: :cascade do |t|
    t.string "token"
    t.string "device_type"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_device_infos_on_user_id"
  end

  create_table "item_favorites", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_favorites_on_item_id"
    t.index ["user_id"], name: "index_item_favorites_on_user_id"
  end

  create_table "item_ratings", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "user_id"
    t.integer "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_ratings_on_item_id"
    t.index ["user_id"], name: "index_item_ratings_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.float "price"
    t.integer "qty"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.bigint "user_id", null: false
    t.float "average_rating"
    t.integer "rating_count"
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["deleted_at"], name: "index_items_on_deleted_at"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "likes", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "post_id"
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "conversation_id", null: false
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status"
    t.integer "qty"
    t.float "sub_total"
    t.float "charges"
    t.float "grand_total"
    t.bigint "item_id"
    t.bigint "address_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "payment_type"
    t.string "payment_detail"
    t.bigint "seller_id"
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["deleted_at"], name: "index_orders_on_deleted_at"
    t.index ["item_id"], name: "index_orders_on_item_id"
    t.index ["seller_id"], name: "index_orders_on_seller_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_portfolios_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "service_category_id"
    t.index ["service_category_id"], name: "index_posts_on_service_category_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "posts_items", id: false, force: :cascade do |t|
    t.bigint "post_id"
    t.bigint "item_id"
    t.index ["item_id"], name: "index_posts_items_on_item_id"
    t.index ["post_id"], name: "index_posts_items_on_post_id"
  end

  create_table "posts_users", id: false, force: :cascade do |t|
    t.bigint "post_id"
    t.bigint "user_id"
    t.index ["post_id"], name: "index_posts_users_on_post_id"
    t.index ["user_id"], name: "index_posts_users_on_user_id"
  end

  create_table "rate_service_providers", force: :cascade do |t|
    t.integer "rate"
    t.bigint "user_id", null: false
    t.bigint "stylist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stylist_id"], name: "index_rate_service_providers_on_stylist_id"
    t.index ["user_id"], name: "index_rate_service_providers_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rpush_apps", force: :cascade do |t|
    t.string "name", null: false
    t.string "environment"
    t.text "certificate"
    t.string "password"
    t.integer "connections", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", null: false
    t.string "auth_key"
    t.string "client_id"
    t.string "client_secret"
    t.string "access_token"
    t.datetime "access_token_expiration"
    t.text "apn_key"
    t.string "apn_key_id"
    t.string "team_id"
    t.string "bundle_id"
    t.boolean "feedback_enabled", default: true
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string "device_token"
    t.datetime "failed_at", precision: nil, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "app_id"
    t.index ["device_token"], name: "index_rpush_feedback_on_device_token"
  end

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer "badge"
    t.string "device_token"
    t.string "sound"
    t.text "alert"
    t.text "data"
    t.integer "expiry", default: 86400
    t.boolean "delivered", default: false, null: false
    t.datetime "delivered_at", precision: nil
    t.boolean "failed", default: false, null: false
    t.datetime "failed_at", precision: nil
    t.integer "error_code"
    t.text "error_description"
    t.datetime "deliver_after", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "alert_is_json", default: false, null: false
    t.string "type", null: false
    t.string "collapse_key"
    t.boolean "delay_while_idle", default: false, null: false
    t.text "registration_ids"
    t.integer "app_id", null: false
    t.integer "retries", default: 0
    t.string "uri"
    t.datetime "fail_after", precision: nil
    t.boolean "processing", default: false, null: false
    t.integer "priority"
    t.text "url_args"
    t.string "category"
    t.boolean "content_available", default: false, null: false
    t.text "notification"
    t.boolean "mutable_content", default: false, null: false
    t.string "external_device_id"
    t.string "thread_id"
    t.boolean "dry_run", default: false, null: false
    t.boolean "sound_is_json", default: false
    t.index ["delivered", "failed", "processing", "deliver_after", "created_at"], name: "index_rpush_notifications_multi", where: "((NOT delivered) AND (NOT failed))"
  end

  create_table "service_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "stylist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stylist_id"], name: "index_service_favorites_on_stylist_id"
    t.index ["user_id"], name: "index_service_favorites_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.time "time"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "service_category_id"
    t.index ["service_category_id"], name: "index_services_on_service_category_id"
    t.index ["user_id"], name: "index_services_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "business_name"
    t.string "location"
    t.string "address"
    t.text "about_me"
    t.string "first_name"
    t.string "last_name"
    t.string "year_of_exp"
    t.datetime "dob"
    t.string "gender"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "facebook_url"
    t.string "insta_url"
    t.string "twitter_url"
    t.bigint "role_id", null: false
    t.datetime "deleted_at"
    t.string "pay_pal_email"
    t.float "average_rating"
    t.integer "rating_count"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appointment_services", "appointments"
  add_foreign_key "appointment_services", "services"
  add_foreign_key "appointments", "users"
  add_foreign_key "appointments", "users", column: "stylist_id"
  add_foreign_key "cart_products", "carts"
  add_foreign_key "cart_products", "items"
  add_foreign_key "carts", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "device_infos", "users"
  add_foreign_key "item_favorites", "items"
  add_foreign_key "item_favorites", "users"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "users"
  add_foreign_key "messages", "conversations"
  add_foreign_key "orders", "users"
  add_foreign_key "orders", "users", column: "seller_id"
  add_foreign_key "portfolios", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "rate_service_providers", "users"
  add_foreign_key "rate_service_providers", "users", column: "stylist_id"
  add_foreign_key "service_favorites", "users"
  add_foreign_key "service_favorites", "users", column: "stylist_id"
  add_foreign_key "services", "users"
  add_foreign_key "users", "roles"
end
