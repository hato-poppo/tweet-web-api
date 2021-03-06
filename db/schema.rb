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

ActiveRecord::Schema.define(version: 2021_05_14_225006) do

  create_table "tweets", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "投稿者"
    t.string "content", null: false, comment: "投稿内容"
    t.datetime "created_at", default: -> { "current_timestamp()" }, comment: "登録日"
    t.datetime "updated_at", default: -> { "current_timestamp()" }, comment: "更新日"
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false, comment: "ユーザー名"
    t.string "account_name", null: false, comment: "表示名"
    t.string "password", comment: "パスワード"
    t.string "email", null: false, comment: "Eメールアドレス"
    t.boolean "is_deleted", default: false, null: false, comment: "削除フラグ"
    t.datetime "created_at", default: -> { "current_timestamp()" }, comment: "登録日"
    t.datetime "updated_at", default: -> { "current_timestamp()" }, comment: "更新日"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "tweets", "users"
end
