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

ActiveRecord::Schema.define(version: 2021_05_25_154025) do

  create_table "drink_products", force: :cascade do |t|
    t.integer "drink_id"
    t.integer "product_id"
    t.string "quantity"
  end

  create_table "drinks", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.string "glass"
    t.string "instructions"
    t.string "photo_url"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "subcategory"
    t.text "description"
  end

  create_table "user_drinks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "drink_id"
  end

  create_table "user_products", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

end
