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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110511132306) do

  create_table "custom_collection_products", :force => true do |t|
    t.integer  "custom_collection_id"
    t.integer  "product_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "custom_collection_products", ["custom_collection_id"], :name => "index_custom_collection_products_on_custom_collection_id"

  create_table "custom_collections", :force => true do |t|
    t.integer  "shop_id"
    t.string   "title"
    t.boolean  "published",      :default => true
    t.string   "handle",                           :null => false
    t.text     "body_html"
    t.string   "products_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "custom_collections", ["shop_id"], :name => "index_custom_collections_on_shop_id"

  create_table "kindeditors", :force => true do |t|
    t.string   "kindeditor_image_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "link_lists", :force => true do |t|
    t.integer  "shop_id"
    t.string   "title"
    t.string   "handle"
    t.boolean  "system_default", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "link_lists", ["shop_id"], :name => "index_link_lists_on_shop_id"

  create_table "links", :force => true do |t|
    t.string   "title"
    t.string   "link_type"
    t.string   "subject_id"
    t.string   "subject_params"
    t.string   "subject"
    t.integer  "link_list_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["link_list_id"], :name => "index_links_on_link_list_id"

  create_table "pages", :force => true do |t|
    t.integer  "shop_id"
    t.string   "title"
    t.boolean  "published",  :default => false
    t.string   "handle",                        :null => false
    t.text     "body_html"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["shop_id"], :name => "index_pages_on_shop_id"

  create_table "photos", :force => true do |t|
    t.integer  "product_id"
    t.string   "product_image_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["product_id"], :name => "index_photos_on_product_id"

  create_table "product_options", :force => true do |t|
    t.integer "product_id", :null => false
    t.string  "name"
    t.integer "positon"
  end

  add_index "product_options", ["product_id"], :name => "index_product_options_on_product_id"

  create_table "product_variants", :force => true do |t|
    t.integer  "product_id",                               :null => false
    t.float    "price",                :default => 0.0,    :null => false
    t.float    "weight",               :default => 0.0,    :null => false
    t.float    "compare_at_price"
    t.string   "option1"
    t.string   "option2"
    t.string   "option3"
    t.string   "sku"
    t.boolean  "requires_shipping",    :default => true
    t.integer  "inventory_quantity",   :default => 1
    t.string   "inventory_management"
    t.string   "inventory_policy",     :default => "deny"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_variants", ["product_id"], :name => "index_product_variants_on_product_id"

  create_table "products", :force => true do |t|
    t.integer  "shop_id",      :null => false
    t.string   "title",        :null => false
    t.text     "description"
    t.string   "product_type"
    t.string   "vendor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["shop_id"], :name => "index_products_on_shop_id"

  create_table "products_tags", :id => false, :force => true do |t|
    t.integer "product_id", :null => false
    t.integer "tag_id",     :null => false
  end

  create_table "shop_product_types", :force => true do |t|
    t.integer "shop_id"
    t.string  "name"
  end

  add_index "shop_product_types", ["shop_id"], :name => "index_shop_product_types_on_shop_id"

  create_table "shop_product_vendors", :force => true do |t|
    t.integer "shop_id"
    t.string  "name"
  end

  add_index "shop_product_vendors", ["shop_id"], :name => "index_shop_product_vendors_on_shop_id"

  create_table "shops", :force => true do |t|
    t.string   "name"
    t.string   "domain"
    t.string   "permanent_domain"
    t.string   "email"
    t.string   "phone"
    t.string   "theme",            :default => "shopqi"
    t.date     "deadline"
    t.string   "title"
    t.string   "province"
    t.string   "city"
    t.string   "address"
    t.string   "keywords"
    t.boolean  "public",           :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "smart_collection_products", :force => true do |t|
    t.integer  "smart_collection_id"
    t.integer  "product_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "smart_collection_products", ["smart_collection_id"], :name => "index_smart_collection_products_on_smart_collection_id"

  create_table "smart_collection_rules", :force => true do |t|
    t.integer  "smart_collection_id"
    t.string   "column"
    t.string   "relation"
    t.string   "condition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "smart_collection_rules", ["smart_collection_id"], :name => "index_smart_collection_rules_on_smart_collection_id"

  create_table "smart_collections", :force => true do |t|
    t.integer  "shop_id"
    t.string   "title"
    t.boolean  "published",      :default => true
    t.string   "handle",                           :null => false
    t.text     "body_html"
    t.string   "products_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "smart_collections", ["shop_id"], :name => "index_smart_collections_on_shop_id"

  create_table "tags", :force => true do |t|
    t.integer "shop_id", :null => false
    t.string  "name",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["shop_id"], :name => "index_users_on_shop_id"

end
