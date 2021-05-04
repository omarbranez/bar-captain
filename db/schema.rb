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

ActiveRecord::Schema.define(version: 2021_05_04_020352) do

  create_table "drink_products", force: :cascade do |t|
    t.integer "drink_id"
    t.integer "product_id"
  end

  create_table "drinks", force: :cascade do |t|
    t.string "name"
    t.string "ingredient1"
    t.decimal "ing_quantity1"
    t.string "ingredient2"
    t.decimal "ing_quantity2"
    t.string "ingredient3"
    t.decimal "ing_quantity3"
    t.string "ingredient4"
    t.decimal "ing_quantity4"
    t.string "ingredient5"
    t.decimal "ing_quantity5"
    t.string "ingredient6"
    t.decimal "ing_quantity6"
    t.text "recipe"
    t.text "image_link"
  end

  create_table "menu_drinks", force: :cascade do |t|
    t.integer "menu_id"
    t.integer "drink_id"
  end

  create_table "menus", force: :cascade do |t|
    t.integer "drink_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "category"
    t.string "subcategory"
    t.decimal "quantity"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

end
