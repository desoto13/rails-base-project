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

ActiveRecord::Schema.define(version: 2021_06_20_123404) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "broker_stocks", force: :cascade do |t|
    t.string "symbol"
    t.decimal "price"
    t.integer "total_sold"
    t.text "info"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_broker_stocks_on_user_id"
  end

  create_table "buyer_stocks", force: :cascade do |t|
    t.string "symbol"
    t.decimal "curr_price"
    t.decimal "bought_price"
    t.decimal "change_price"
    t.decimal "gains_loss"
    t.integer "shares"
    t.text "info"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_buyer_stocks_on_user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "symbol"
    t.decimal "price"
    t.text "info"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string "symbol"
    t.decimal "price"
    t.integer "total_shares"
    t.integer "shares"
    t.string "buyer"
    t.string "broker"
    t.bigint "user_id"
    t.bigint "stock_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stock_id"], name: "index_transactions_on_stock_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

end
